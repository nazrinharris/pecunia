import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/debug/debug_transactions/form/debug_transactions_form.dart';
import 'package:pecunia/presentation/debug/debug_transactions/providers/debug_transactions_provider.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebugTransactionsScreen extends ConsumerWidget {
  const DebugTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureDialog(
              title: 'Oopsies',
              failure: next.error as Failure?,
            );
      }

      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        ref.read(pecuniaDialogsProvider).showSuccessDialog(
              title: 'Transaction successfully created!',
            );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Transactions'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          const Divider(),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Create a Transaction',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          const CreateTransactionForm(),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'View All Transactions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          const ViewAllTransactions(),
        ],
      ),
    );
  }
}

class CreateTransactionForm extends ConsumerWidget {
  const CreateTransactionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = ref.watch(createTransactionFormProvider);
    final accountsList = ref.watch(getAllAccountsProvider);
    return accountsList.when(
      data: (accounts) => ReactiveForm(
        formGroup: formGroup,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'txnName',
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => formGroup.focus('description'),
                decoration: const InputDecoration(
                  labelText: 'Transaction Name',
                  hintText: 'Give a short name for this transaction',
                ),
              ),
              ReactiveTextField<String>(
                formControlName: 'description',
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
                formControlName: 'type',
                onChanged: (formControl) => formGroup.focus('account'),
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
              ReactiveDropdownField<String>(
                formControlName: 'account',
                decoration: const InputDecoration(
                  labelText: 'Account',
                  hintText: 'Choose an account to add this transaction to',
                ),
                onChanged: (control) {
                  ref.watch(chosenAccountProvider.notifier).updateChosenAccount(accounts, control.value!);
                  formGroup.focus('amount');
                },
                items: buildAccountsDropdown(accounts),
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 14, right: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        // border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        ref.watch(chosenAccountProvider).toNullable()?.currency ?? '-',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: ReactiveTextField<String>(
                      formControlName: 'amount',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Couple bucks? A few hundred?',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return ElevatedButton(
                    onPressed: form.valid
                        ? () => ref.read(createTransactionProvider.notifier).createTransaction(
                              name: form.value['txnName']! as String,
                              description: form.value['description'] as String?,
                              amount: double.parse(form.value['amount']! as String),
                              currency: ref.watch(chosenAccountProvider).toNullable()!.currency,
                              accountId: ref.watch(chosenAccountProvider).toNullable()!.id,
                              type: form.value['type']! as String,
                            )
                        : null,
                    child: const Text('Create Transaction'),
                  );
                },
              )
            ],
          ),
        ),
      ),
      error: (f, stack) {
        final failure = f as Failure;
        return Center(
          child: Text(failure.toString()),
        );
      },
      loading: () => const Center(child: CupertinoActivityIndicator()),
    );
  }

  List<DropdownMenuItem<String>> buildAccountsDropdown(List<Account> accountsList) {
    final items = <DropdownMenuItem<String>>[];
    for (final account in accountsList) {
      items.add(
        DropdownMenuItem<String>(
          value: account.id,
          child: Text(account.name),
        ),
      );
    }
    return items;
  }
}

class ViewAllTransactions extends ConsumerWidget {
  const ViewAllTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(getAllTransactionsProvider);
    return transactionsList.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return const Center(
            child: Text('No transactions yet!'),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              title: Text(transaction.name),
              subtitle: Text(transaction.transactionDescription.value ?? 'No description'),
              trailing: Text(transaction.fundDetails.originalAmount.toString()),
            );
          },
        );
      },
      error: (err, s) => Center(child: Text(err.toString())),
      loading: () => const Center(child: CupertinoActivityIndicator()),
    );
  }
}
