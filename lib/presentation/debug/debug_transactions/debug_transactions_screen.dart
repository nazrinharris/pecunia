import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_all_transactions.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/debug/debug_forms/create_txn_form_widget.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

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

class CreateTransactionForm extends HookConsumerWidget {
  const CreateTransactionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsList = ref.watch(getAllAccountsProvider);
    return accountsList.when(
      data: (accounts) => CreateTxnForm(
        accountsList: accounts,
        initialTransactionType: TransactionType.credit,
        disableCloseButton: true,
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
          child: Text(
            account.name,
            overflow: TextOverflow.ellipsis,
          ),
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
    final accountsList = ref.watch(getAllAccountsProvider);
    return transactionsList.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return const Center(
            child: Text('No transactions yet!'),
          );
        }

        final account = accountsList.whenData((list) {
          if (list.isEmpty) {
            throw Exception('No accounts found, but transactions exist!');
          }

          return list.firstWhere((element) => element.id == transactions.first.accountId);
        }).asData!;

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
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          returnAccountName(
                              txn.accountId, accountsList.whenData((value) => value).asData?.value ?? []),
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
                      showTransactionBottomSheet(context, txn, account.value);
                    },
                  ),
                  Divider(color: Colors.grey.withOpacity(0.1)),
                ],
              );
            },
          ),
        );
      },
      error: (err, s) {
        final except = err as TransactionsFailure;
        return Center(
          child: Text(except.message),
        );
      },
      loading: () => const Center(child: CupertinoActivityIndicator()),
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
