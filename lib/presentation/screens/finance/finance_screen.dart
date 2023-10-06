import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
import 'package:simple_animations/simple_animations.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: RefreshIndicator(
      displacement: 100,
      onRefresh: () async {
        ref
          ..invalidate(getAllTransactionsProvider)
          ..invalidate(getAllAccountsProvider);
      },
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Finance',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      'Management',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const AddBudgetButton(),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    ));
  }
}

class AddBudgetButton extends HookConsumerWidget {
  const AddBudgetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = useState(Control.stop);

    return CustomAnimationBuilder(
      control: control.value,
      tween: MovieTween()
        ..tween(
          'scale',
          Tween<double>(begin: 1, end: 0.95),
          duration: const Duration(milliseconds: 100),
        )
        ..tween(
          'opacity',
          Tween<double>(begin: 1, end: 0.8),
          duration: const Duration(milliseconds: 100),
        ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Transform.scale(
        scale: value.get('scale'),
        child: Opacity(
          opacity: value.get('opacity'),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTapDown: (details) {
          control.value = Control.play;
        },
        onTapUp: (details) async {
          await HapticFeedback.lightImpact();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.playReverse;
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.stop;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'Add Budget',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewAllTransactions extends ConsumerWidget {
  const ViewAllTransactions({super.key, this.maxTxnShown});

  final int? maxTxnShown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(getAllTransactionsProvider);
    final accountsList = ref.watch(getAllAccountsProvider);

    return switch ((transactionsList, accountsList)) {
      (AsyncLoading(), _) || (_, AsyncLoading()) => const Center(child: CupertinoActivityIndicator()),
      (AsyncError(:final Object error), _) => Center(child: Text((error as Failure).message)),
      (_, AsyncError(:final Object error)) => Center(child: Text((error as Failure).message)),
      (
        AsyncData(value: final List<Transaction> txnList),
        AsyncData(value: final List<Account> accountsList)
      ) =>
        ViewAllTransactionsList(txnList, accountsList, maxTxnShown: maxTxnShown),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class ViewAllTransactionsList extends ConsumerWidget {
  const ViewAllTransactionsList(this.txns, this.accounts, {super.key, this.maxTxnShown});

  final List<Transaction> txns;
  final List<Account> accounts;
  final int? maxTxnShown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (txns.isEmpty) {
      return const Center(
        child: Text('No transactions yet!'),
      );
    }

    // Sort transactions by date, most recent first
    final sortedTxns = txns..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));

    // Remove excess transactions if any, based on `maxTxnShown`
    if (maxTxnShown != null && sortedTxns.length > maxTxnShown!) {
      sortedTxns.removeRange(maxTxnShown!, sortedTxns.length);
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
            itemCount: sortedTxns.length,
            itemBuilder: (context, index) {
              final txn = sortedTxns[index];

              if (txn.isTransferTransaction) {
                return TransferTxnListTile(
                  account: returnAccount(txn.accountId, accounts),
                  txn: txn,
                  enableTopDivider: index == 0,
                  enableBottomDivider: index == sortedTxns.length - 1,
                );
              }

              final categoryValue = ref.watch(getCategoriesByTxnIdProvider(txn.id));

              return switch (categoryValue) {
                AsyncLoading() => Column(
                    children: [
                      if (index == 0) Divider(color: Colors.grey.withOpacity(0.1)),
                      const ListTile(title: CupertinoActivityIndicator()),
                      if (index == sortedTxns.length - 1) Divider(color: Colors.grey.withOpacity(0.1)),
                    ],
                  ),
                AsyncError(:final Object error) => TxnListTileError(
                    error as Failure,
                    enableTopDivider: index == 0,
                    enableBottomDivider: index == sortedTxns.length - 1,
                  ),
                AsyncData(:final List<Category?> value) => TxnListTile(
                    account: returnAccount(txn.accountId, accounts),
                    txn: txn,
                    category: value.length == 1 ? value.first : null,
                    enableTopDivider: index == 0,
                    enableBottomDivider: index == sortedTxns.length - 1,
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
