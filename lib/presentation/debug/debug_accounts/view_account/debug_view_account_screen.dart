// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_provider.dart';
import 'package:pecunia/presentation/debug/debug_local_db/providers/debug_local_db_provider.dart';
import 'package:pecunia/presentation/debug/debug_transactions/debug_transactions_screen.dart';
import 'package:pecunia/presentation/debug/debug_transactions/form/debug_transactions_form.dart';
import 'package:pecunia/presentation/debug/debug_transactions/providers/debug_transactions_provider.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebugViewAccountScreen extends ConsumerWidget {
  const DebugViewAccountScreen(this.accountId, {super.key});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(deleteAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't delete your account.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Account deleted successfully!',
              );
        }
      })
      ..listen(editTransactionProvider, (previous, next) {
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(deleteTransactionProvider, (previous, next) {
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      });

    final acc = ref.watch(getAccountByIdProvider(accountId));

    switch (acc) {
      case AsyncLoading():
        return const Center(child: CircularProgressIndicator());
      case AsyncError():
        return const Center(child: Text('Error loading account'));
      case AsyncData():
        return AccountDetails(acc.value);
      default:
        throw UnimplementedError();
    }
  }
}

class AccountDetails extends ConsumerWidget {
  const AccountDetails(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            if (account.description.value != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Text(
                  account.description.value ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
            const Divider(),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Initial balance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                        text: account.initialBalance.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${account.currency}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Current balance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                        text: account.balance.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${account.currency}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 14),
            SafeArea(child: AccountMetadataCard(account)),
            const SizedBox(height: 4),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Text('Add income', style: TextStyle(color: Colors.green[100])),
                        leading: Icon(Icons.add, color: Colors.green[100]),
                        onTap: () {
                          showCreateTransactionBottomSheet(context, account, true);
                        },
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Text('Add expense', style: TextStyle(color: Colors.red[100])),
                        leading: Icon(Icons.remove, color: Colors.red[100]),
                        onTap: () {
                          showCreateTransactionBottomSheet(context, account, false);
                        },
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: const Text('Edit account'),
                        leading: const Icon(Icons.edit),
                        onTap: () {
                          context.pushNamed('debug-edit-account', extra: account);
                        },
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Text('Delete account', style: TextStyle(color: Colors.red[300])),
                        leading: Icon(Icons.delete, color: Colors.red[300]),
                        onTap: () {
                          ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                              title: 'Are you sure you want to delete this account?',
                              message: 'This is irreversible',
                              onConfirm: () {
                                ref.read(deleteAccountProvider.notifier).deleteAccount(account);
                              },
                              context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                alignment: Alignment.center,
                child: const Text(
                  'Transactions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SafeArea(child: TransactionsList(account)),
          ],
        ),
      ),
    );
  }
}

class TransactionsList extends ConsumerWidget {
  const TransactionsList(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnList = ref.watch(getTransactionsByAccountIdProvider(account.id));
    return txnList.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return const Center(
            child: Text('No transactions yet!'),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final txn = transactions[index];

              return Column(
                children: [
                  if (index == 0) Divider(color: Colors.grey.withOpacity(0.1)),
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          account.name,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          txn.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: txn.transactionDescription.value == null
                        ? null
                        : Text(
                            txn.transactionDescription.value!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    trailing: BuildTxnAmountText(txn),
                    onTap: () {
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          showDragHandle: true,
                          builder: (context) {
                            return SizedBox(
                              height: 550,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                child: BottomSheetContent(txn, [], account),
                              ),
                            );
                          });
                    },
                  ),
                  Divider(color: Colors.grey.withOpacity(0.1)),
                ],
              );
            },
          ),
        );
      },
      error: (e, stack) {
        return Center(
          child: Text(e.toString()),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  String returnAccountName(String accountId, List<Account> accounts) {
    if (accounts.isEmpty) {
      return '';
    }

    final account = accounts.firstWhere((element) => element.id == accountId);
    return account.name;
  }
}

class AccountMetadataCard extends ConsumerWidget {
  const AccountMetadataCard(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (Option<bool> isValid, actualBalance) = ref.watch(validateAccountBalanceProvider(account)).when(
          data: (d) => (Option.of(d.$1), d.$2),
          error: (e, s) => (const Option.none(), (e as Failure).message),
          loading: () => (const Option.none(), 'loading...'),
        );

    final isValidText = isValid.match(() => 'error', (t) => t.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                text: 'acc_id: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: account.id,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              RichText(
                  text: TextSpan(
                text: 'creator_id: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: account.creatorUid,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              RichText(
                  text: TextSpan(
                text: 'created_at: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: account.createdOn.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              RichText(
                  text: TextSpan(
                text: 'is_balance_valid: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: isValidText,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              RichText(
                  text: TextSpan(
                text: 'reported_balance: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: account.balance.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 4),
              RichText(
                  text: TextSpan(
                text: 'actual_balance: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: actualBalance.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

void showCreateTransactionBottomSheet(BuildContext context, Account account, bool isCredit) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SizedBox(
          height: 750,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                CreateTransactionForm(account, isCredit),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      });
}

class CreateTransactionForm extends HookConsumerWidget {
  const CreateTransactionForm(this.account, this.isCredit, {super.key});

  final Account account;
  final bool isCredit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createTransactionProvider, (prev, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureDialog(
              title: "We couldn't delete your account.",
              failure: next.error as Failure?,
            );
      }
      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        context.pop();
        ref.read(pecuniaDialogsProvider).showSuccessDialog(
              title: 'Transaction created successfully!',
            );
        ref
          ..invalidate(getTransactionsByAccountIdProvider(account.id))
          ..invalidate(getAccountByIdProvider(account.id));
      }
    });
    final typeDefault = isCredit ? 'credit' : 'debit';
    final formGroup =
        ref.watch(createTransactionFormProvider(typeDefault: typeDefault, accountId: account.id));

    final isIncome = useState(formGroup.value['type'] == 'credit');
    final isIncomeText = isIncome.value ? 'Income' : 'Expense';
    final isIncomeTextColor = isIncome.value ? Colors.green[100] : Colors.red[100];

    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isIncome.value ? Colors.green[900]!.withOpacity(0.1) : Colors.red[900]!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: isIncome.value
                      ? Colors.green[100]!.withOpacity(0.3)
                      : Colors.red[100]!.withOpacity(0.3)),
            ),
            alignment: Alignment.center,
            child: Align(
              child: RichText(
                  text: TextSpan(
                text: isIncomeText,
                style: TextStyle(
                  color: isIncomeTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: ' Transaction',
                    style: TextStyle(
                      color: isIncomeTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
            ),
          ),
          CreateTransactionFormFields(
            account,
            formGroup,
            isIncome,
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}

class CreateTransactionFormFields extends HookConsumerWidget {
  const CreateTransactionFormFields(
    this.account,
    this.formGroup,
    this.isIncome, {
    super.key,
  });

  final Account account;
  final FormGroup formGroup;
  final ValueNotifier<bool> isIncome;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fundDetailsControllerProvider(formGroup));

    final isCurrencyExchangeEnabled = ref.watch(isCurrencyExchangeEnabledProvider);
    formGroup.control(CreateFields.targetCurrency).value = account.currency;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: CreateFields.name,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => formGroup.focus('description'),
            decoration: const InputDecoration(
              labelText: 'Transaction Name',
              hintText: 'Give a short name for this transaction',
            ),
          ),
          ReactiveTextField<String>(
            formControlName: CreateFields.description,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) {
              if (formGroup.value['description'] == '') {
                formGroup.value['description'] = null;
              }
              formGroup.focus('currency');
            },
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'You could also leave this empty.',
            ),
          ),
          ReactiveDropdownField<String>(
            formControlName: CreateFields.type,
            isExpanded: true,
            onChanged: (formControl) {
              isIncome.value = formControl.value == 'credit';
              formGroup.focus('account');
            },
            decoration: const InputDecoration(
              labelText: 'Transaction Type',
              hintText: 'Is this an income or an expense?',
            ),
            items: [
              DropdownMenuItem<String>(
                value: TransactionType.credit.typeAsString,
                child: const Text('Income (or known as credit)'),
              ),
              DropdownMenuItem<String>(
                value: TransactionType.debit.typeAsString,
                child: const Text('Expense (or known as debit)'),
              ),
            ],
          ),
          SizedBox(
            height: 75,
            width: double.infinity,
            child: ReactiveDropdownField<String>(
              isExpanded: true,
              readOnly: true,
              formControlName: CreateFields.account,
              decoration: InputDecoration(
                labelText: account.name,
                hintText: 'Choose an account',
              ),
              onChanged: (control) {
                formGroup.focus('amount');
              },
              selectedItemBuilder: (context) {
                return [Text(account.name)];
              },
              items: [
                DropdownMenuItem<String>(
                  value: account.id,
                  child: Text(
                    account.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.purple[900]!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.purple[100]!.withOpacity(0.2)),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Fund Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          SwitchListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on_outlined),
                const Icon(Icons.swap_horiz),
                const SizedBox(width: 8),
                Text(
                  'Enable currency exchange',
                  style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            value: ref.watch(isCurrencyExchangeEnabledProvider),
            onChanged: (val) {
              ref.read(isCurrencyExchangeEnabledProvider.notifier).setValue(val);

              if (val == false) {
                ref.read(fundDetailsControllerProvider(formGroup).notifier).disableCurrencyExchange();
              } else {
                ref.read(fundDetailsStateProvider.notifier).setFormState(FundDetailsFieldState.baseAndTarget);
                ref.read(fundDetailsControllerProvider(formGroup).notifier).setForBaseAndTarget();
                formGroup.control(CreateFields.baseCurrency).value = 'XXX';
              }
            },
          ),
          const SizedBox(height: 14),
          if (ref.watch(isCurrencyExchangeEnabledProvider))
            DropdownButtonFormField<FundDetailsFieldState>(
              isExpanded: true,
              hint: const Text('Choose how you want to enter the amounts'),
              value: ref.watch(fundDetailsStateProvider),
              items: [
                const DropdownMenuItem(
                  value: FundDetailsFieldState.baseAndExchange,
                  child: Text("I'll set the Base Amount and Exchange Rate"),
                ),
                const DropdownMenuItem(
                  value: FundDetailsFieldState.baseAndTarget,
                  child: Text("I'll set the Base Amount and Target Amount"),
                ),
                const DropdownMenuItem(
                  value: FundDetailsFieldState.targetAndExchange,
                  child: Text("I'll set the Target Amount and Exchange Rate"),
                ),
              ],
              onChanged: (val) {
                ref.read(fundDetailsStateProvider.notifier).setFormState(val!);

                switch (ref.watch(fundDetailsStateProvider)) {
                  case FundDetailsFieldState.baseAndTarget:
                    ref.read(fundDetailsControllerProvider(formGroup).notifier).setForBaseAndTarget();
                  case FundDetailsFieldState.baseAndExchange:
                    ref.read(fundDetailsControllerProvider(formGroup).notifier).setForBaseAndExchange();
                  case FundDetailsFieldState.targetAndExchange:
                    ref.read(fundDetailsControllerProvider(formGroup).notifier).setForTargetAndExchange();
                  case FundDetailsFieldState.notSet:
                    throw UnimplementedError();
                }
              },
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BuildBaseAmountCurrency(isCurrencyExchangeEnabled, account, formGroup),
              const SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: ReactiveTextField<String>(
                  key: const Key(CreateFields.baseAmount),
                  formControlName: CreateFields.baseAmount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: isCurrencyExchangeEnabled ? 'Base Amount' : 'Amount',
                    hintText: 'Couple bucks? A few hundred?',
                  ),
                  onChanged: (control) {
                    if (isCurrencyExchangeEnabled) {
                      ref.read(fundDetailsControllerProvider(formGroup).notifier).onAnyFieldSubmitted();
                    }
                  },
                ),
              ),
            ],
          ),
          if (isCurrencyExchangeEnabled) ...[
            ReactiveTextField<String>(
                key: const Key(CreateFields.exchangeRate),
                formControlName: CreateFields.exchangeRate,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  icon: Icon(Icons.swap_horiz),
                  labelText: 'Exchange Rate (optional)',
                  hintText: 'You can just enter the base and target amount.',
                ),
                onChanged: (control) {
                  ref.read(fundDetailsControllerProvider(formGroup).notifier).onAnyFieldSubmitted();
                }),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    // alignment: Alignment.center,
                    child: ReactiveDropdownField(
                      isExpanded: true,
                      readOnly: true,
                      borderRadius: BorderRadius.circular(14),
                      formControlName: CreateFields.targetCurrency,
                      decoration: const InputDecoration(border: InputBorder.none),
                      items: [
                        DropdownMenuItem(
                          value: account.currency,
                          child: Center(
                            child: Text(
                              account.currency,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 3,
                  child: ReactiveTextField<String>(
                    key: const Key(CreateFields.targetAmount),
                    formControlName: CreateFields.targetAmount,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Target Amount',
                      hintText: 'Couple bucks? A few hundred?',
                    ),
                    onChanged: (control) =>
                        ref.read(fundDetailsControllerProvider(formGroup).notifier).onAnyFieldSubmitted(),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          ReactiveFormConsumer(
            builder: (context, form, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      print(ref.read(fundDetailsControllerProvider(formGroup)));
                      print(form.value);
                    },
                    child: const Text('Debug'),
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey[800]!; // the color when button is disabled
                          }
                          return Colors.purple[900]!; // the color when button is enabled
                        },
                      ),
                    ),
                    onPressed: form.valid
                        ? () {
                            final name = form.value[CreateFields.name]!;
                            final description = form.value[CreateFields.description];
                            final baseAmount = form.value[CreateFields.baseAmount];
                            final baseCurrency = form.value[CreateFields.baseCurrency]!;
                            final type = form.value[CreateFields.type]!;
                            final exchangeRate = form.value[CreateFields.exchangeRate];
                            final targetAmount = form.value[CreateFields.targetAmount];
                            final targetCurrency = form.value[CreateFields.targetCurrency];

                            ref.read(createTransactionProvider.notifier).createTransaction(
                                  name: name as String,
                                  description: description as String?,
                                  baseAmount: baseAmount == null ? null : double.parse(baseAmount as String),
                                  baseCurrency: baseCurrency as String,
                                  accountId: account.id,
                                  transactionType: type as String,
                                  exchangeRate:
                                      exchangeRate == null ? null : double.parse(exchangeRate as String),
                                  targetAmount:
                                      targetAmount == null ? null : double.parse(targetAmount as String),
                                  targetCurrency: targetCurrency as String?,
                                );
                            form.unfocus();
                          }
                        : null,
                    child: const Text('Create Transaction'),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class BuildBaseAmountCurrency extends ConsumerStatefulWidget {
  const BuildBaseAmountCurrency(
    this.isCurrencyExchangeEnabled,
    this.account,
    this.formGroup, {
    super.key,
  });

  final bool isCurrencyExchangeEnabled;
  final FormGroup formGroup;
  final Account account;

  @override
  ConsumerState<BuildBaseAmountCurrency> createState() => _BuildBaseAmountCurrencyState();
}

class _BuildBaseAmountCurrencyState extends ConsumerState<BuildBaseAmountCurrency> {
  String selectedCurrencyCode = 'XXX';

  @override
  Widget build(BuildContext context) {
    if (widget.isCurrencyExchangeEnabled) {
      return Flexible(
        fit: FlexFit.tight,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey.withOpacity(0.2)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Material(
                color: Colors.transparent,
                child: PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  initialValue: selectedCurrencyCode,
                  onSelected: (String value) {
                    setState(() {
                      selectedCurrencyCode = value;
                    });
                    // After getting the selected value, update the formControl value
                    widget.formGroup.control(CreateFields.baseCurrency).value = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return PecuniaCurrencies.toList().map<PopupMenuItem<String>>((Currency c) {
                      return PopupMenuItem<String>(
                        value: c.code,
                        child: Text('${c.code} - ${c.name}', textAlign: TextAlign.center),
                      );
                    }).toList();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          selectedCurrencyCode,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        // fit: FlexFit.tight,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            // border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.account.currency,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
