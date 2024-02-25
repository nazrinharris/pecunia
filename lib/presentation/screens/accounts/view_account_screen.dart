// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id_and_all_accounts.dart';
import 'package:pecunia/features/accounts/usecases/validate_account_balance.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_categories_by_txn_id.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/widgets/common/scale_button.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_transfer_txn_form_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_txn_form_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/transfer_txn_list_tile_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/txn_list_tile.dart';

class ViewAccountScreen extends ConsumerWidget {
  const ViewAccountScreen(this.accountId, {super.key});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(deleteAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't delete your account.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Account deleted successfully!',
              );
        }
      })
      ..listen(editAccountProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: 'Something went wrong while editing your account.',
                failure: next.error as AccountsFailure?,
              );
        }

        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Your account has been edited!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      });

    final res = ref.watch(getAccountByIdAndAllAccountsProvider(accountId));

    switch (res) {
      case AsyncLoading(:final value) when value == null:
        return const Center(child: CupertinoActivityIndicator());
      case AsyncLoading(:final value) when value != null:
        return AccountDetails(value.account, value.accountsList);
      case AsyncError():
        return const Center(child: Text('Error loading account'));
      case AsyncData():
        return AccountDetails(res.value.account, res.value.accountsList);
      default:
        throw UnimplementedError();
    }
  }
}

class AccountDetails extends ConsumerWidget {
  const AccountDetails(this.account, this.accountsList, {super.key});

  final Account account;
  final List<Account> accountsList;

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
                            text: ' ${account.currency.code}',
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
                        text: account.balance.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${account.currency.code}',
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
            SafeArea(child: AccountActions(account, accountsList)),
            // SafeArea(
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            //     alignment: Alignment.center,
            //     child: const Text(
            //       'Transactions',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 14),
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
      data: (txnList) {
        if (txnList.isEmpty) {
          return const Center(
            child: Text('No transactions yet!'),
          );
        }

        final sortedTxnList = txnList.sortedByMostRecent;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedTxnList.length,
            itemBuilder: (context, index) {
              final txn = sortedTxnList[index];

              if (txn.isTransferTransaction) {
                return MonthHeader(
                  txn: txn,
                  prevTxn: index == 0 ? null : txnList[index - 1],
                  child: TransferTxnListTile(
                    account: account,
                    txn: txn,
                    enableTopDivider: index == 0,
                    enableBottomDivider: index == sortedTxnList.length - 1,
                  ),
                );
              }

              // TODO: Optimize category retrieval
              final categoryValue = ref.watch(getCategoriesByTxnIdProvider(txn.id));

              return switch (categoryValue) {
                AsyncLoading() => Column(
                    children: [
                      if (index == 0) Divider(color: Colors.grey.withOpacity(0.1)),
                      const ListTile(title: CupertinoActivityIndicator()),
                      if (index == sortedTxnList.length - 1) Divider(color: Colors.grey.withOpacity(0.1)),
                    ],
                  ),
                AsyncError(:final Object error) => MonthHeader(
                    txn: txn,
                    prevTxn: index == 0 ? null : txnList[index - 1],
                    child: TxnListTileError(
                      error as Failure,
                      enableTopDivider: index == 0,
                      enableBottomDivider: index == sortedTxnList.length - 1,
                    ),
                  ),
                AsyncData(:final List<Category?> value) => MonthHeader(
                    txn: txn,
                    prevTxn: index == 0 ? null : txnList[index - 1],
                    child: TxnListTile(
                      account: account,
                      txn: txn,
                      category: value.length == 1 ? value.first : null,
                      enableTopDivider: index == 0,
                      enableBottomDivider: index == sortedTxnList.length - 1,
                      hideAccountName: true,
                    ),
                  ),
                _ => const Center(child: Text('Something went wrong')),
              };
            },
          ),
        );
      },
      error: (e, stack) {
        if (e is Failure) {
          return Center(
            child: Text(
              e.message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[100]),
            ),
          );
        }

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

class MonthHeader extends ConsumerWidget {
  const MonthHeader({
    required this.txn,
    required this.prevTxn,
    required this.child,
    super.key,
  });

  final Widget child;
  final Transaction txn;
  final Transaction? prevTxn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (prevTxn == null) {
      return Column(
        children: [
          buildHeader(context, ref),
          child,
        ],
      );
    }

    final shouldBuild = txn.transactionDate.month != prevTxn!.transactionDate.month ||
        txn.transactionDate.year != prevTxn!.transactionDate.year;

    return Column(
      children: [
        if (shouldBuild) buildHeader(context, ref),
        if (shouldBuild) Divider(color: Colors.grey.withOpacity(0.1)),
        child,
      ],
    );
  }

  Widget buildHeader(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      alignment: Alignment.center,
      child: Text(
        '${txn.transactionDate.month.monthName} ${txn.transactionDate.year}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
      ),
    );
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

class AccountActions extends ConsumerWidget {
  const AccountActions(this.account, this.accountsList, {super.key});

  final Account account;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 420) {
          return SizedBox(
            height: 84,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                BuildAccountActionsGrid(account: account, accountsList: accountsList),
              ],
            ),
          );
        }

        return BuildAccountActionsGrid(account: account, accountsList: accountsList);
      }),
    );
  }
}

class BuildAccountActionsGrid extends ConsumerWidget {
  const BuildAccountActionsGrid({
    required this.account,
    required this.accountsList,
    super.key,
  });

  final Account account;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 84,
          width: 84,
          child: ScaleButton(
            onTap: () => showCreateTxnBottomSheet(context, true, account: account),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.green[900]!.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.green[100], size: 32),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 84,
          width: 84,
          child: ScaleButton(
            onTap: () => showCreateTxnBottomSheet(context, false, account: account),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.red[900]!.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove, color: Colors.red[100], size: 32),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 84,
          width: 84,
          child: ScaleButton(
            onTap: () => showCreateTransferTxnBottomSheet(context, account, accountsList),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.blue[900]!.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.compare_arrows, color: Colors.blue[100], size: 32),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 84,
          width: 84,
          child: ScaleButton(
            onTap: () => context.pushNamed('debug-edit-account', extra: account),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.purple[900]!.withOpacity(0.1),
              child: Icon(CupertinoIcons.pencil, color: Colors.purple[100], size: 32),
            ),
          ),
        ),
        SizedBox(
          height: 84,
          width: 84,
          child: ScaleButton(
            onTap: () => ref.read(pecuniaDialogsProvider).showTextEntryConfirmationDialog(
                title: 'Are you sure you want to delete this account?',
                description: 'This action cannot be undone.',
                entryConfirmationText: 'DELETE',
                confirmButtonText: 'Delete',
                onConfirm: () {
                  ref.read(deleteAccountProvider.notifier).deleteAccount(account);
                },
                context: context),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: Colors.red[900]!.withOpacity(0.1),
              child: Icon(Icons.delete_forever, color: Colors.red[100], size: 30),
            ),
          ),
        ),
      ],
    );
  }
}
