// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async' as a;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/accounts/usecases/validate_account_balance.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/providers/get_linked_account_and_txn.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/transfer_txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/debug/debug_forms/create_transfer_txn_form_widget.dart';
import 'package:pecunia/presentation/debug/debug_forms/create_txn_form_widget.dart';
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
      ..listen(createTransactionProvider, (prev, next) {
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
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(editTransactionProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't edit your account.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Transaction edited successfully!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(deleteTransactionProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: 'Oopsies',
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Transaction deleted succesfully!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(editAccountProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: 'Something went wrong while editing your account.',
                failure: next.error as AccountsFailure?,
              );
        }

        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Your account has been edited!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(createTransferTransactionProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: 'Unable to create transfer transaction.',
                failure: next.error as TransactionsFailure?,
              );
        }

        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Transfer transaction created successfully!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      })
      ..listen(deleteTransferTransactionProvider, (previous, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: 'Unable to create transfer transaction.',
                failure: next.error as TransactionsFailure?,
              );
        }

        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Transfer transaction deleted successfully!',
              );
          ref
            ..invalidate(getTransactionsByAccountIdProvider(accountId))
            ..invalidate(getAccountByIdProvider(accountId));
        }
      });

    final acc = ref.watch(getAccountByIdProvider(accountId));

    switch (acc) {
      case AsyncLoading():
        return const Center(child: CupertinoActivityIndicator());
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
            SafeArea(child: AccountActionsGrid(account)),
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

              return txn.isTransferTransaction
                  ? TransferTxnListTile(
                      account: account,
                      txn: txn,
                      enableTopDivider: index == 0,
                    )
                  : TxnListTile(account: account, txn: txn, enableTopDivider: index == 0);
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

class TxnListTile extends StatelessWidget {
  const TxnListTile({
    required this.account,
    required this.txn,
    this.enableTopDivider = false,
    this.enableBottomDivider = true,
    this.hideAccountName = false,
    this.onTap,
    super.key,
  });

  final Account account;
  final Transaction txn;
  final bool enableTopDivider;
  final bool enableBottomDivider;
  final bool hideAccountName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!hideAccountName)
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
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.question_mark, color: Colors.grey[100]),
          ),
          onTap: onTap ??
              () {
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
                        child: TxnBottomSheet(txn, account),
                      );
                    });
              },
        ),
        if (enableBottomDivider) Divider(color: Colors.grey.withOpacity(0.1)),
      ],
    );
  }
}

// TODO: Update this to allow passing in values which has been previously collected, specifically the linkedAccount and linkedTransaction
class TransferTxnListTile extends ConsumerWidget {
  const TransferTxnListTile({
    required this.account,
    required this.txn,
    this.enableTopDivider = false,
    this.enableBottomDivider = true,
    this.onTap,
    this.debugReturnErrorAccount,
    this.debugReturnErrorTransaction,
    super.key,
  });

  final Account account;
  final Transaction txn;
  final bool enableTopDivider;
  final bool enableBottomDivider;
  final void Function()? onTap;

  //TODO: Remove debug exception return
  final bool? debugReturnErrorAccount;
  final bool? debugReturnErrorTransaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkedAccountAndTxnValue = ref.watch(getLinkedAccountAndTxnProvider(
      accountId: txn.transferDetails!.linkedAccountId,
      txnId: txn.transferDetails!.linkedTransactionId,
      debugReturnErrorAccount: debugReturnErrorAccount,
      debugReturnErrorTransaction: debugReturnErrorTransaction,
    ));

    return switch (linkedAccountAndTxnValue) {
      AsyncLoading() => Column(
          children: [
            if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
            const ListTile(title: CupertinoActivityIndicator()),
            if (enableBottomDivider) Divider(color: Colors.grey.withOpacity(0.1)),
          ],
        ),
      AsyncData(value: (final Account linkedAccount, final Transaction linkedTransaction)) =>
        BuildTransferTxnContent(
          txn: txn,
          linkedTxn: linkedTransaction,
          account: account,
          linkedAccount: linkedAccount,
          onTap: onTap,
          enableTopDivider: enableTopDivider,
          enableBottomDivider: enableBottomDivider,
        ),
      AsyncError(
        error: ParallelWaitError(
          errors: (final a.AsyncError? accountError, final a.AsyncError? transactionsError),
          values: (final Account? _, final Transaction? _),
        ),
        stackTrace: _
      ) =>
        BuildTransferTxnError(
          error: (accountError ?? transactionsError!).error as Failure,
          txn: txn,
          onTap: onTap,
          enableTopDivider: enableTopDivider,
          enableBottomDivider: enableBottomDivider,
        ),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class BuildTransferTxnError extends StatelessWidget {
  const BuildTransferTxnError({
    required this.error,
    required this.txn,
    required this.onTap,
    required this.enableTopDivider,
    required this.enableBottomDivider,
    this.title,
    super.key,
  });

  final Failure error;
  final String? title;
  final Transaction txn;
  final void Function()? onTap;
  final bool enableTopDivider;
  final bool enableBottomDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? 'Something went wrong',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[200],
                ),
              ),
            ],
          ),
          subtitle: Text(
            error.message,
            style: TextStyle(color: Colors.white.withOpacity(0.3)),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[100]!.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(color: Colors.red[900]!, width: 2),
            ),
            child: Icon(
              Icons.report_problem_outlined,
              color: Colors.red[900],
            ),
          ),
          onTap: onTap,
        ),
        if (enableBottomDivider) Divider(color: Colors.grey.withOpacity(0.1)),
      ],
    );
  }
}

class BuildTransferTxnContent extends StatelessWidget {
  const BuildTransferTxnContent({
    required this.txn,
    required this.linkedTxn,
    required this.account,
    required this.linkedAccount,
    required this.onTap,
    required this.enableTopDivider,
    required this.enableBottomDivider,
    super.key,
  });

  final Transaction txn;
  final Transaction linkedTxn;
  final Account account;
  final Account linkedAccount;
  final void Function()? onTap;
  final bool enableTopDivider;
  final bool enableBottomDivider;

  @override
  Widget build(BuildContext context) {
    final toOrFromText = txn.fundDetails.transactionType == TransactionType.credit ? 'From' : 'To';

    return Column(
      children: [
        if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$toOrFromText ${linkedAccount.name}',
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
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: txn.fundDetails.transactionType == TransactionType.credit
                  ? Colors.green[900]!.withOpacity(0.3)
                  : Colors.red[900]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.compare_arrows,
              color: txn.fundDetails.transactionType == TransactionType.credit
                  ? Colors.green[100]
                  : Colors.red[200],
            ),
          ),
          onTap: onTap ??
              () {
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
                        child: TransferTxnBottomSheet(
                          txn: txn,
                          linkedTxn: linkedTxn,
                          account: account,
                          linkedAccount: linkedAccount,
                        ),
                      );
                    });
              },
        ),
        if (enableBottomDivider) Divider(color: Colors.grey.withOpacity(0.1)),
      ],
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

void showCreateTransactionBottomSheet(BuildContext context, Account account, bool isCredit) {
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
                CreateTxnForm(
                  account: account,
                  initialTransactionType: isCredit ? TransactionType.credit : TransactionType.debit,
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      });
}

void showCreateTransferTxnBottomSheet(BuildContext context, Account account) {
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
                  accountsList: [account],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      });
}

class AccountActionsGrid extends ConsumerWidget {
  const AccountActionsGrid(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.green[900]!.withOpacity(0.1),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                showCreateTransactionBottomSheet(context, account, true);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HeroIcons.currency_dollar, color: Colors.green[100]),
                  Icon(Icons.add, color: Colors.green[100]),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.red[900]!.withOpacity(0.1),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                showCreateTransactionBottomSheet(context, account, false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HeroIcons.currency_dollar, color: Colors.red[100]),
                  Icon(Icons.remove, color: Colors.red[100]),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[900]!.withOpacity(0.1),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                showCreateTransferTxnBottomSheet(context, account);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HeroIcons.currency_dollar, color: Colors.blue[100]),
                  Icon(Icons.compare_arrows, color: Colors.blue[100]),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.purple[900]!.withOpacity(0.1),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                context.pushNamed('debug-edit-account', extra: account);
              },
              child: Icon(HeroIcons.pencil, color: Colors.purple[100]),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.red[900]!.withOpacity(0.1),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                    title: 'Are you sure you want to delete this account?',
                    message: 'This is irreversible',
                    onConfirm: () {
                      ref.read(deleteAccountProvider.notifier).deleteAccount(account);
                    },
                    context: context);
              },
              child: Icon(HeroIcons.trash, color: Colors.red[100]),
            ),
          ),
        ],
      ),
    );
  }
}
