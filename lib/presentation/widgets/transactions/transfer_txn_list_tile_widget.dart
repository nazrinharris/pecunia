// TODO: Update this to allow passing in values which has been previously collected, specifically the linkedAccount and linkedTransaction
import 'dart:async' as a;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/shared/get_linked_account_and_txn.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/widgets/transactions/transfer_txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/txn_bottom_sheet_widget.dart';

/// If `onTap` is not provided, then the transaction will be displayed in a bottom sheet
class TransferTxnListTile extends ConsumerWidget {
  const TransferTxnListTile({
    required this.account,
    required this.txn,
    this.enableTopDivider = false,
    this.enableBottomDivider = true,
    this.onTap,
    this.debugReturnErrorAccount,
    this.debugReturnErrorTransaction,
    this.defaultLinkedAccountAndTxn,
    this.showLinkedAccountName = false,
    super.key,
  });

  final Account account;
  final Transaction txn;
  final bool enableTopDivider;
  final bool enableBottomDivider;
  final void Function()? onTap;
  final bool showLinkedAccountName;

  //TODO: Remove debug exception return
  final bool? debugReturnErrorAccount;
  final bool? debugReturnErrorTransaction;

  final ({Account linkedAccount, Transaction linkedTransaction})? defaultLinkedAccountAndTxn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (defaultLinkedAccountAndTxn != null) {
      return BuildTransferTxnContent(
        txn: txn,
        linkedTxn: defaultLinkedAccountAndTxn!.linkedTransaction,
        account: account,
        linkedAccount: defaultLinkedAccountAndTxn!.linkedAccount,
        onTap: onTap,
        enableTopDivider: enableTopDivider,
        enableBottomDivider: enableBottomDivider,
        showLinkedAccountName: showLinkedAccountName,
      );
    }

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
          showLinkedAccountName: showLinkedAccountName,
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
    required this.showLinkedAccountName,
    super.key,
  });

  final Transaction txn;
  final Transaction linkedTxn;
  final Account account;
  final Account linkedAccount;
  final void Function()? onTap;
  final bool enableTopDivider;
  final bool enableBottomDivider;
  final bool showLinkedAccountName;

  @override
  Widget build(BuildContext context) {
    final toOrFromTextBase = txn.fundDetails.transactionType == TransactionType.credit ? 'From' : 'To';
    final toOrFromTextTarget = txn.fundDetails.transactionType == TransactionType.credit ? 'To' : 'From';

    return Column(
      children: [
        if (enableTopDivider) Divider(color: Colors.grey.withOpacity(0.1)),
        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLinkedAccountName)
                Text(
                  '$toOrFromTextTarget ${account.name}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              Text(
                '$toOrFromTextBase ${linkedAccount.name}',
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
