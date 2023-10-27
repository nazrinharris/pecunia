import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_transfer_txn_form_widget.dart';
import 'package:screwdriver/screwdriver.dart';

void showEditTransferTxnBottomSheet(
  BuildContext context, {
  required Transaction txn,
  required Transaction linkedTxn,
}) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditTransferTxnForm(
                  txn: txn,
                  linkedTxn: linkedTxn,
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      });
}

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

class EditTransferTxnForm extends HookConsumerWidget {
  const EditTransferTxnForm({
    required this.txn,
    required this.linkedTxn,
    super.key,
  });

  final Transaction txn;
  final Transaction linkedTxn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(editTransferTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureDialog(
              context: context,
              title: 'Unable to create transfer transaction.',
              failure: next.error as Failure?,
            );
      }
      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        context
          ..pop()
          ..pop();
        ref.read(pecuniaDialogsProvider).showSuccessDialog(
              context: context,
              title: 'Updated transfer transaction!',
            );
        ref
          ..invalidate(getTransactionsByAccountIdProvider(txn.accountId))
          ..invalidate(getAccountByIdProvider(txn.accountId));
      }
    });

    final sourceTxn = txn.fundDetails.transactionType == TransactionType.debit ? txn : linkedTxn;
    final destinationTxn = txn.fundDetails.transactionType == TransactionType.credit ? txn : linkedTxn;

    final accountsListValue = ref.watch(getAllAccountsProvider);

    return switch (accountsListValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final AccountsFailure error) => Center(child: Text(error.message)),
      AsyncData(value: final List<Account> accountsList) when accountsList.length == 1 => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'You need two accounts to transfer funds. How did you even get here? (seriously, please report this to me)',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      AsyncData(value: final List<Account> accountsList) => EditTransferFormContent(
          accountsList,
          sourceTxn: sourceTxn,
          destinationTxn: destinationTxn,
        ),
      _ => const Center(child: Text('"getAllAccounts" returned an unknown state')),
    };
  }
}

class EditTransferFormContent extends HookConsumerWidget {
  const EditTransferFormContent(
    this.accountsList, {
    required this.sourceTxn,
    required this.destinationTxn,
    super.key,
  });

  final List<Account> accountsList;
  final Transaction sourceTxn;
  final Transaction destinationTxn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final chosenSourceAccount =
        useState(accountsList.firstWhere((account) => account.id == sourceTxn.accountId));
    final chosenDestinationAccount =
        useState<Account>(accountsList.firstWhere((account) => account.id == destinationTxn.accountId));
    final exchangeRate = useState<double?>(sourceTxn.fundDetails.exchangeRate);

    final sourceAmountController =
        useTextEditingController(text: sourceTxn.fundDetails.transactionAmount.toString());
    final destinationAmountController =
        useTextEditingController(text: destinationTxn.fundDetails.transactionAmount.toString());
    final transferDescriptionController =
        useTextEditingController(text: sourceTxn.transferDetails!.transferDescription.value);

    final isDifferentCurrency = chosenSourceAccount.value.currency != chosenDestinationAccount.value.currency;

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
                  Text(
                    'Transfer Transaction',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.blue[100],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
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

                  await ref.read(editTransferTransactionProvider.notifier).editTransferTransaction(
                        sourceAccount: chosenSourceAccount.value,
                        destinationAccount: chosenDestinationAccount.value,
                        sourceTransactionAmount: sourceAmountController.text.toDoubleOrNull()!,
                        destinationTransactionAmount: destinationAmountInput,
                        exchangeRate: exchangeRate.value,
                        transferDescription: transferDescriptionController.text,
                        oldSourceTxn: sourceTxn,
                        oldDestinationTxn: destinationTxn,
                      );
                }
              },
              child: const Text('Update Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
