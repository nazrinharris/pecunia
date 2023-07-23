// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/accounts/usecases/validate_account_balance.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/debug/debug_forms/create_txn_form_widget.dart';
import 'package:pecunia/presentation/debug/debug_transactions/debug_transactions_screen.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

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
                        text: account.balance.toStringAsFixed(2),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      builder: (context) {
        return SizedBox(
          height: 700,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                CreateTxnForm(
                  account: account,
                  initialTransactionType: isCredit ? TransactionType.credit : TransactionType.debit,
                ),
                //CreateTransactionForm(account, isCredit),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      });
}
