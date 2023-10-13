import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_all_transactions.dart';
import 'package:pecunia/features/transactions/usecases/get_categories_by_txn_id.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/transfer_txn_list_tile_widget.dart';

class RecentTxnList extends ConsumerWidget {
  const RecentTxnList({super.key, this.maxTxnShown});

  final int? maxTxnShown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(getAllTransactionsProvider);
    final accountsList = ref.watch(getAllAccountsProvider);

    return switch ((transactionsList, accountsList)) {
      (AsyncLoading(), _) || (_, AsyncLoading()) => const LoadingTxnList(),
      (AsyncError(:final Object error), _) => Center(child: Text((error as Failure).message)),
      (_, AsyncError(:final Object error)) => Center(child: Text((error as Failure).message)),
      (
        AsyncData(value: final List<Transaction> txnList),
        AsyncData(value: final List<Account> accountsList)
      ) =>
        sortAndReturnTxnList(txnList, accountsList),
      _ => const Center(child: Text('Something went wrong')),
    };
  }

  Widget sortAndReturnTxnList(List<Transaction> txns, List<Account> accounts) {
    // sort
    final sortedTxn = txns..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    // limit
    final limitedTxn = maxTxnShown != null ? sortedTxn.take(maxTxnShown!).toList() : sortedTxn;

    return TxnList(limitedTxn, accounts);
  }
}

class LoadingTxnList extends ConsumerWidget {
  const LoadingTxnList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: CupertinoActivityIndicator());
  }
}

class TxnList extends ConsumerWidget {
  const TxnList(this.txns, this.accounts, {super.key});

  final List<Transaction> txns;
  final List<Account> accounts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (txns.isEmpty) {
      return const Center(
        child: Text('No transactions yet!'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              textAlign: TextAlign.left,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: txns.length,
            itemBuilder: (context, index) {
              final txn = txns[index];

              if (txn.isTransferTransaction) {
                return TransferTxnListTile(
                  account: returnAccount(txn.accountId, accounts),
                  txn: txn,
                  enableTopDivider: index == 0,
                  enableBottomDivider: index == txns.length - 1,
                );
              }

              final categoryValue = ref.watch(getCategoriesByTxnIdProvider(txn.id));

              return switch (categoryValue) {
                AsyncLoading() => Column(
                    children: [
                      if (index == 0) Divider(color: Colors.grey.withOpacity(0.1)),
                      const ListTile(title: CupertinoActivityIndicator()),
                      if (index == txns.length - 1) Divider(color: Colors.grey.withOpacity(0.1)),
                    ],
                  ),
                AsyncError(:final Object error) => TxnListTileError(
                    error as Failure,
                    enableTopDivider: index == 0,
                    enableBottomDivider: index == txns.length - 1,
                  ),
                AsyncData(:final List<Category?> value) => TxnListTile(
                    account: returnAccount(txn.accountId, accounts),
                    txn: txn,
                    category: value.length == 1 ? value.first : null,
                    enableTopDivider: index == 0,
                    enableBottomDivider: index == txns.length - 1,
                  ),
                _ => const Center(child: Text('Something went wrong')),
              };
            },
          ),
        ],
      ),
    );
  }

  Account returnAccount(String accountId, List<Account> accounts) {
    if (accounts.isEmpty) {
      throw Exception('No accounts exists, but this method was called!');
    }

    final account = accounts.firstWhere((element) => element.id == accountId);
    return account;
  }
}
