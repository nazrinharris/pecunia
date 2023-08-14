import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/usecases/create_transfer_transaction.dart';
import 'package:pecunia/presentation/debug/debug_forms/create_transfer_txn_form_widget.dart';
import 'package:screwdriver/screwdriver.dart';

// TODO: Update the fields
class EditTransferTxnFields {
  static String? validateTransferDescription(String? val) {
    if (val != null && val.length > 500) {
      return 'Please enter a description less than 500 characters';
    }
    return null;
  }

  static String? validateTransferAmount(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an amount';
    }
    if (double.tryParse(val) == null) {
      return 'Please enter a valid amount';
    }
    return null;
  }
}

// TODO: Update the widget
class EditTransferTxnForm extends HookConsumerWidget {
  const EditTransferTxnForm({
    required this.defaultSourceAccount,
    required this.accountsList,
    super.key,
  });

  final Account? defaultSourceAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsListValue = ref.watch(getAllAccountsProvider);

    return switch (accountsListValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final AccountsFailure error) => Center(child: Text(error.message)),
      AsyncData(value: final List<Account> accountsList) when accountsList.length == 1 => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'You need at least 2 accounts to transfer money.',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      AsyncData(value: final List<Account> accountsList) => TransferFormContent(
          defaultSourceAccount,
          accountsList,
        ),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class TransferFormContent extends HookConsumerWidget {
  const TransferFormContent(
    this.defaultSourceAccount,
    this.accountsList, {
    super.key,
  });

  final Account? defaultSourceAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final chosenSourceAccount = useState(defaultSourceAccount ?? accountsList.first);
    final chosenDestinationAccount = useState<Account?>(null);
    final exchangeRate = useState<double?>(null);

    final sourceAmountController = useTextEditingController();
    final destinationAmountController = useTextEditingController();
    final transferDescriptionController = useTextEditingController();

    final isDifferentCurrency = chosenDestinationAccount.value != null &&
        chosenSourceAccount.value.currency != chosenDestinationAccount.value!.currency;

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transfer Transaction',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.blue[100])),
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red[900]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red[100]),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.red[100]),
                    ],
                  ),
                ),
                Expanded(
                    child:
                        SourceAccountDropdown(chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            const SizedBox(height: 8),
            SourceAmountField(
              chosenSourceAccount.value.currency,
              sourceAmountController,
              isDifferentCurrency,
            ),
            if (!isDifferentCurrency) const SizedBox(height: 8),
            if (isDifferentCurrency)
              ExchangeRateField(
                sourceAccount: chosenSourceAccount.value,
                destinationAccount: chosenDestinationAccount.value,
                sourceAmountController: sourceAmountController,
                destinationAmountController: destinationAmountController,
                exchangeRate: exchangeRate,
              ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green[900]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[100]),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_back, color: Colors.green[100]),
                    ],
                  ),
                ),
                Expanded(
                    child: DestinationAccountDropdown(
                        chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            const SizedBox(height: 8),
            if (isDifferentCurrency)
              DestinationAmountField(
                sourceAccount: chosenSourceAccount.value,
                destinationAccount: chosenDestinationAccount.value,
                destinationController: destinationAmountController,
              ),
            TextFormField(
              controller: transferDescriptionController,
              decoration: const InputDecoration(
                labelText: "What's the transfer about?",
                hintText: 'This is optional',
              ),
              maxLines: null,
              validator: EditTransferTxnFields.validateTransferDescription,
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (formKey.value.currentState!.validate()) {
                  double? destinationAmountInput;

                  if (isDifferentCurrency) {
                    destinationAmountInput = destinationAmountController.text.toDoubleOrNull();
                  }

                  await ref.read(createTransferTransactionProvider.notifier).createTransferTransaction(
                        sourceAccount: chosenSourceAccount.value,
                        destinationAccount: chosenDestinationAccount.value!,
                        sourceTransactionAmount: sourceAmountController.text.toDoubleOrNull()!,
                        destinationTransactionAmount: destinationAmountInput,
                        exchangeRate: exchangeRate.value,
                        transferDescription: transferDescriptionController.text,
                      );
                }
              },
              child: const Text('Create Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
