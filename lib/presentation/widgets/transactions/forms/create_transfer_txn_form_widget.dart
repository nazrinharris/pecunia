// TODO: Remove ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/usecases/create_transfer_transaction.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:screwdriver/screwdriver.dart';

void showCreateTransferTxnBottomSheet(BuildContext context, Account account, List<Account> accountsList) {
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
              CreateTransferTxnForm(
                defaultSourceAccount: account,
                accountsList: accountsList,
              ),
              const SizedBox(height: 94),
            ],
          ),
        ),
      );
    },
  );
}

class CreateTransferTxnFields {
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

/// Providing a [defaultSourceAccount] disables the ability to change the `chosenSourceAccount`
class CreateTransferTxnForm extends HookConsumerWidget {
  const CreateTransferTxnForm({
    required this.defaultSourceAccount,
    required this.accountsList,
    super.key,
  });

  final Account? defaultSourceAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createTransferTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureToast(
              context: context,
              title: 'Unable to create transfer transaction.',
              failure: next.error as TransactionsFailure?,
            );
      }

      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        context.pop();
        ref.read(pecuniaDialogsProvider).showSuccessToast(
              context: context,
              title: 'Transfer transaction created successfully!',
            );
      }
    });

    if (accountsList.length < 2) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'You need at least 2 accounts to transfer money.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return TransferFormContent(
      defaultSourceAccount,
      accountsList,
    );
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
        padding: EdgeInsets.symmetric(horizontal: 14),
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
            SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.red[100]),
                    ],
                  ),
                ),
                Expanded(
                    child:
                        SourceAccountDropdown(chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            SizedBox(height: 8),
            SourceAmountField(
              chosenSourceAccount.value.currency,
              sourceAmountController,
              isDifferentCurrency,
            ),
            if (!isDifferentCurrency) SizedBox(height: 8),
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
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      SizedBox(width: 8),
                      Icon(Icons.arrow_back, color: Colors.green[100]),
                    ],
                  ),
                ),
                Expanded(
                    child: DestinationAccountDropdown(
                        chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            SizedBox(height: 8),
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
              validator: CreateTransferTxnFields.validateTransferDescription,
            ),
            SizedBox(height: 28),
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
              child: Text('Create Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExchangeRateField extends HookConsumerWidget {
  const ExchangeRateField({
    required this.sourceAccount,
    required this.destinationAccount,
    required this.sourceAmountController,
    required this.destinationAmountController,
    required this.exchangeRate,
    super.key,
  });

  final Account sourceAccount;
  final Account? destinationAccount;
  final TextEditingController sourceAmountController;
  final TextEditingController destinationAmountController;
  final ValueNotifier<double?> exchangeRate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        void updateExchangeRate() {
          if (destinationAccount != null &&
              sourceAccount.currency != destinationAccount!.currency &&
              sourceAmountController.text.isNumeric &&
              destinationAmountController.text.isNumeric) {
            final sourceAmount = double.parse(sourceAmountController.text);
            final destinationAmount = double.parse(destinationAmountController.text);
            final rate = destinationAmount / sourceAmount;

            exchangeRate.value = rate;
          }
        }

        sourceAmountController.addListener(updateExchangeRate);
        destinationAmountController.addListener(updateExchangeRate);
        return () {
          sourceAmountController.removeListener(updateExchangeRate);
          destinationAmountController.removeListener(updateExchangeRate);
        };
      },
      [sourceAccount, destinationAccount, sourceAmountController, destinationAmountController],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Align(
        child: Column(
          children: [
            Text('transferring with an exchange rate of approximately',
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4))),
            Text(exchangeRate.value?.toStringAsFixed(5) ?? 'undefined'),
          ],
        ),
      ),
    );
  }
}

class SourceAmountField extends HookConsumerWidget {
  const SourceAmountField(this.sourceCurrency, this.sourceController, this.isDifferentCurrency, {super.key});

  final Currency sourceCurrency;
  final TextEditingController sourceController;
  final bool isDifferentCurrency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isDifferentCurrency
                  ? Colors.red[900]!.withOpacity(0.2)
                  : Colors.blue[900]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Amount ',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDifferentCurrency ? Colors.red[100] : Colors.blue[100],
                    ),
                  ),
                  TextSpan(
                    text: sourceCurrency.code,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDifferentCurrency ? Colors.red[100] : Colors.blue[100],
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
            child: TextFormField(
          controller: sourceController,
          decoration: const InputDecoration(hintText: 'Enter amount'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: CreateTransferTxnFields.validateTransferAmount,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )),
      ],
    );
  }
}

class DestinationAmountField extends HookConsumerWidget {
  const DestinationAmountField({
    required this.sourceAccount,
    required this.destinationAccount,
    required this.destinationController,
    super.key,
  });

  final Account sourceAccount;
  final Account? destinationAccount;
  final TextEditingController destinationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green[900]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'Amount ', style: TextStyle(fontSize: 16, color: Colors.green[100])),
                  TextSpan(
                      text: destinationAccount?.currency.code ?? '---',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[100])),
                ],
              ),
            )),
        Expanded(
            child: TextFormField(
          controller: destinationController,
          decoration: const InputDecoration(hintText: 'Enter amount'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: CreateTransferTxnFields.validateTransferAmount,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )),
      ],
    );
  }
}

class SourceAccountDropdown extends HookConsumerWidget {
  const SourceAccountDropdown(this.chosenSourceAccount, this.chosenDestinationAccount, this.accountsList,
      {super.key});

  final ValueNotifier<Account> chosenSourceAccount;
  final ValueNotifier<Account?> chosenDestinationAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = accountsList.map((account) => account.id);
    final uniqueIds = ids.toSet();
    if (ids.length != uniqueIds.length) {
      print('There are duplicate accounts in the list');
    }
    if (!accountsList.contains(chosenSourceAccount.value)) {
      print('The chosen source account is not in the accounts list');
      // You may want to handle this case appropriately
    }

    return DropdownButtonFormField<Account>(
      isExpanded: true,
      value: chosenSourceAccount.value,
      onChanged: (Account? newSource) {
        if (chosenDestinationAccount.value != null && newSource!.id == chosenDestinationAccount.value!.id) {
          chosenDestinationAccount.value = chosenSourceAccount.value;
        }
        chosenSourceAccount.value = newSource!;
      },
      items: accountsList.map<DropdownMenuItem<Account>>((Account value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      hint: Text('Select Source Account'),
      decoration: InputDecoration(),
    );
  }
}

class DestinationAccountDropdown extends HookConsumerWidget {
  const DestinationAccountDropdown(this.chosenSourceAccount, this.chosenDestinationAccount, this.accountsList,
      {super.key});

  final ValueNotifier<Account> chosenSourceAccount;
  final ValueNotifier<Account?> chosenDestinationAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<Account>(
      isExpanded: true,
      value: chosenDestinationAccount.value,
      onChanged: (Account? newDestination) {
        if (newDestination!.id == chosenSourceAccount.value.id) {
          chosenSourceAccount.value = chosenDestinationAccount.value ??
              accountsList.firstWhere((account) => account.id != newDestination.id);
        }
        chosenDestinationAccount.value = newDestination;
      },
      items: accountsList.map<DropdownMenuItem<Account>>((Account value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      hint: Text('Select Destination Account'),
      validator: (value) => value == null ? 'Please select an account' : null,
    );
  }
}
