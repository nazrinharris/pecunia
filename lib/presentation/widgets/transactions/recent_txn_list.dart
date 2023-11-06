// ignore_for_file: prefer_const_constructors
import 'dart:async' as a;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/shared/get_all_txns_and_accounts.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_categories_by_txn_id.dart';
import 'package:pecunia/presentation/widgets/transactions/transfer_txn_list_tile_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/txn_list_tile.dart';

class RecentTxnList extends ConsumerWidget {
  const RecentTxnList({
    super.key,
    this.maxTxnShown,
    this.showTitle = true,
    this.showViewMoreButton = true,
    this.elevation = 1,
    this.horizontalMargin = 8,
  });

  final int? maxTxnShown;
  final bool showTitle;
  final bool showViewMoreButton;
  final double elevation;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnsAndAccountsList = ref.watch(getAllTxnsAndAccountsProvider);

    return switch (txnsAndAccountsList) {
      AsyncLoading(value: (final List<Transaction> txns, final List<Account> accounts)) =>
        sortAndReturnTxnList(txns, accounts),
      AsyncLoading(value: null) => const LoadingTxnList(),
      AsyncError(
        error: ParallelWaitError(
          errors: (final a.AsyncError? txnsError, final a.AsyncError? accountError),
          values: (final List<Transaction>? _, final List<Account>? _)
        ),
        stackTrace: _
      ) =>
        ErrorTxnList((txnsError ?? accountError!).error as Failure),
      AsyncData(value: (final List<Transaction> txns, final List<Account> accounts)) =>
        sortAndReturnTxnList(txns, accounts),
      _ => const Center(child: Text('Something went wrong')),
    };
  }

  Widget sortAndReturnTxnList(List<Transaction> txns, List<Account> accounts) {
    // sort
    final sortedTxn = txns..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    // limit
    final limitedTxn = maxTxnShown != null ? sortedTxn.take(maxTxnShown!).toList() : sortedTxn;

    return TxnList(
      limitedTxn,
      accounts,
      showTitle: showTitle,
      showViewMoreButton: showViewMoreButton,
      elevation: elevation,
      horizontalMargin: horizontalMargin,
    );
  }
}

class LoadingTxnList extends ConsumerWidget {
  const LoadingTxnList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 256,
              child: CupertinoActivityIndicator(),
            ),
          )
        ],
      ),
    );
  }
}

class ErrorTxnList extends ConsumerWidget {
  const ErrorTxnList(this.failure, {super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 256,
              child: Text(failure.message),
            ),
          )
        ],
      ),
    );
  }
}

class TxnList extends ConsumerWidget {
  const TxnList(
    this.txns,
    this.accounts, {
    required this.showTitle,
    required this.showViewMoreButton,
    required this.elevation,
    required this.horizontalMargin,
    super.key,
  });

  final List<Transaction> txns;
  final List<Account> accounts;
  final bool showTitle;
  final bool showViewMoreButton;
  final double elevation;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Recent Transactions',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                textAlign: TextAlign.left,
              ),
            ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: elevation,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: txns.isEmpty ? buildEmptyTxnList() : buildTxnList(ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyTxnList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: const Center(
        child: Text('No transactions yet!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  ListView buildTxnList(WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: txns.length + 1,
      itemBuilder: (context, index) {
        if (index == txns.length) {
          if (!showViewMoreButton) {
            return const SizedBox.shrink();
          }
          return Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              onPressed: () {
                context.pushNamed('recent-txns');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('View More'),
                  SizedBox(width: 8),
                  Icon(Icons.more_horiz),
                ],
              ),
            ),
          );
        }

        final txn = txns[index];

        if (txn.isTransferTransaction) {
          return TransferTxnListTile(
            account: returnAccount(txn.accountId, accounts),
            txn: txn,
            enableBottomDivider: false,
            showLinkedAccountName: true,
          );
        }

        final categoryValue = ref.watch(getCategoriesByTxnIdProvider(txn.id));

        return switch (categoryValue) {
          AsyncLoading() => const Column(
              children: [
                ListTile(title: CupertinoActivityIndicator()),
              ],
            ),
          AsyncError(:final Object error) => TxnListTileError(
              error as Failure,
              enableBottomDivider: false,
            ),
          AsyncData(:final List<Category?> value) => TxnListTile(
              account: returnAccount(txn.accountId, accounts),
              txn: txn,
              category: value.length == 1 ? value.first : null,
              enableBottomDivider: false,
            ),
          _ => const Center(child: Text('Something went wrong')),
        };
      },
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
