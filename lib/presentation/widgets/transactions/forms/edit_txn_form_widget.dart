import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_categories_by_txn_id.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_txn_form_widget.dart';

void showEditTransactionBottomSheet(
    BuildContext context, Transaction txn, Account account, Category? category) {
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
                EditTxnForm(txn: txn, account: account, category: category),
                const SizedBox(height: 94),
              ],
            ),
          ),
        );
      });
}

class EditTxnForm extends HookConsumerWidget {
  const EditTxnForm({
    required this.txn,
    required this.account,
    required this.category,
    this.disableCloseButton = false,
    super.key,
  });

  final Account account;
  final Transaction txn;
  final Category? category;
  final bool disableCloseButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(editTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureToast(
              context: context,
              title: "We couldn't edit your account.",
              failure: next.error as Failure?,
            );
      }
      if (next is AsyncData<Option<TransactionId>> && next.value.isSome()) {
        context
          ..pop()
          ..pop();
        ref.read(pecuniaDialogsProvider).showSuccessToast(
              context: context,
              title: 'Transaction edited successfully!',
            );
        ref
          ..invalidate(getTransactionsByAccountIdProvider(txn.accountId))
          ..invalidate(getAccountByIdProvider(txn.accountId))
          ..invalidate(
            getCategoriesByTxnIdProvider(
              next.value.getOrElse(() {
                throw Exception(
                    'Expected a value of TransactionId. This is a fatal error, should never be null.');
              }),
            ),
          );
      }
    });

    final chosenAccount = useState(account);

    final txnType = useState(txn.fundDetails.transactionType);
    final isCurrencyExchangeEnabled = useState(txn.fundDetails.isMultiCurrency);
    final formKey = useState(GlobalKey<FormState>());

    final nameController = useTextEditingController(text: txn.name);
    final descriptionController = useTextEditingController(text: txn.transactionDescription.value);
    final baseAmountController = useTextEditingController(text: txn.fundDetails.baseAmount.toString());
    final exchangeRateController = useTextEditingController(
        text: txn.fundDetails.exchangeRate == null ? '' : txn.fundDetails.exchangeRate!.toString());
    final targetAmountController = useTextEditingController(
        text: txn.fundDetails.targetAmount == null ? '' : txn.fundDetails.targetAmount!.toString());

    final baseCurrency = useState(txn.fundDetails.baseCurrency);
    final targetCurrency = useState(txn.fundDetails.targetCurrency ?? chosenAccount.value.currency);

    final oldCategory = category;
    final chosenCategory = useState(category);

    final nameNode = useFocusNode();
    final descriptionNode = useFocusNode();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: formKey.value,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${txnType.value.toDisplayName()} Transaction',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: txnType.value.isCredit() ? Colors.green[200] : Colors.red[200],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!disableCloseButton)
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
            TextFormField(
              controller: nameController,
              focusNode: nameNode,
              validator: CreateTxnFields.validateTxnName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (value) => descriptionNode.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Transaction Name',
                hintText: 'Enter a name for your transaction',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              focusNode: descriptionNode,
              maxLines: null,
              validator: CreateTxnFields.validateTxnDescription,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description for your transaction',
              ),
            ),
            const SizedBox(height: 8),
            ChooseAccountField(chosenAccount: chosenAccount),
            const SizedBox(height: 14),
            Column(
              children: TransactionType.values.map((type) {
                return Container(
                  decoration: BoxDecoration(
                    color: txnType.value == type
                        ? (txnType.value.isCredit()
                            ? Colors.green[200]!.withOpacity(0.2)
                            : Colors.red[200]!.withOpacity(0.2))
                        : null,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: RadioListTile<TransactionType>(
                    title: Text(type.toDisplayName()),
                    value: type,
                    groupValue: txnType.value,
                    activeColor: txnType.value.isCredit() ? Colors.green[200] : Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    onChanged: (val) => txnType.value = val!,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            CategoryField(chosenCategory),
            const SizedBox(height: 14),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fund Details',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: isCurrencyExchangeEnabled.value,
              onChanged: (val) => isCurrencyExchangeEnabled.value = val,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: isCurrencyExchangeEnabled.value
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : null,
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_horiz),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Enable currency exchange',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 3,
                  child: BaseCurrencyField(
                    chosenAccount.value,
                    baseCurrency,
                    txnType,
                    isCurrencyExchangeEnabled,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: BaseAmountField(
                    baseAmountController: baseAmountController,
                    exchangeRateController: exchangeRateController,
                    targetAmountController: targetAmountController,
                  ),
                )
              ],
            ),
            if (isCurrencyExchangeEnabled.value) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Icon(Icons.swap_vert_rounded, size: 32),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ExchangeRateField(
                      baseAmountController: baseAmountController,
                      exchangeRateController: exchangeRateController,
                      targetAmountController: targetAmountController,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 3,
                    child: TargetCurrencyField(
                      chosenAccount.value,
                      targetCurrency,
                      txnType,
                      isCurrencyExchangeEnabled,
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: TargetAmountField(
                        baseAmountController: baseAmountController,
                        exchangeRateController: exchangeRateController,
                        targetAmountController: targetAmountController,
                      ))
                ],
              )
            ],
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () async {
                if (formKey.value.currentState!.validate()) {
                  double? exchangeRateInput;
                  double? targetAmountInput;
                  Currency? targetCurrencyInput;

                  if (isCurrencyExchangeEnabled.value) {
                    exchangeRateInput = double.parse(exchangeRateController.text);
                    targetAmountInput = double.parse(targetAmountController.text);
                    targetCurrencyInput = targetCurrency.value;
                  }

                  await ref.read(editTransactionProvider.notifier).editTransaction(
                    name: nameController.text,
                    description: descriptionController.text,
                    transactionType: txnType.value,
                    baseAmount: double.parse(baseAmountController.text),
                    baseCurrency: baseCurrency.value.isoCode,
                    exchangeRate: exchangeRateInput,
                    targetCurrency: targetCurrencyInput?.isoCode,
                    targetAmount: targetAmountInput,
                    oldTxn: txn,
                    category: (old: oldCategory, current: chosenCategory.value),
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              child: const Text('Update Transaction'),
            ),
            const SizedBox(height: 300)
          ],
        ),
      ),
    );
  }
}
