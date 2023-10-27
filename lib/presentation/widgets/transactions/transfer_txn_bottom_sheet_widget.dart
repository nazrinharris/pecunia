import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/edit_transfer_txn_form_widget.dart';
import 'package:pecunia/presentation/widgets/transactions/transfer_txn_list_tile_widget.dart';

class TransferTxnBottomSheet extends ConsumerWidget {
  const TransferTxnBottomSheet({
    required this.txn,
    required this.linkedTxn,
    required this.account,
    required this.linkedAccount,
    super.key,
  });

  final Transaction txn;
  final Transaction linkedTxn;
  final Account account;
  final Account linkedAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deleteTransferTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureToast(
              context: context,
              title: 'Unable to create transfer transaction.',
              failure: next.error as TransactionsFailure?,
            );
      }

      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        context.pop();
        ref.read(pecuniaDialogsProvider).showSuccessToast(
              context: context,
              title: 'Transfer transaction deleted successfully!',
            );
        ref
          ..invalidate(getTransactionsByAccountIdProvider(txn.accountId))
          ..invalidate(getAccountByIdProvider(txn.accountId));
      }
    });

    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'This is a transfer of ',
                        style: Theme.of(context).textTheme.headlineSmall,
                        children: [
                          TextSpan(
                            text: '${txn.fundDetails.baseAmount} ${txn.fundDetails.baseCurrency.code}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: txn.fundDetails.transactionType == TransactionType.credit
                                      ? Colors.green[300]
                                      : Colors.red[300],
                                ),
                          ),
                          TextSpan(
                            text: ' from ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: txn.fundDetails.transactionType == TransactionType.debit
                                ? account.name
                                : linkedAccount.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[300],
                                ),
                          ),
                          TextSpan(
                            text: ' to ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: txn.fundDetails.transactionType == TransactionType.debit
                                ? linkedAccount.name
                                : account.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[300],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
              ],
            ),
          ),
          const SizedBox(height: 8),
          TransferTxnListTile(
            account: account,
            txn: txn,
            enableTopDivider: true,
            defaultLinkedAccountAndTxn: (linkedAccount: linkedAccount, linkedTransaction: linkedTxn),
            onTap: () {},
          ),
          TransferTxnListTile(
            account: linkedAccount,
            txn: linkedTxn,
            defaultLinkedAccountAndTxn: (linkedAccount: account, linkedTransaction: txn),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showEditTransferTxnBottomSheet(
                        context,
                        txn: txn,
                        linkedTxn: linkedTxn,
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.purple[900]!.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.purple[100],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Icon(CupertinoIcons.pencil, color: Colors.purple[100]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                            title: 'Delete transfer transaction?',
                            message: "You can't undo this, so be careful!",
                            onConfirm: () {
                              ref.read(deleteTransferTransactionProvider.notifier).deleteTransaction(txn);
                            },
                            context: context,
                          );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Colors.red[900]!.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red[100],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(CupertinoIcons.trash, color: Colors.red[100]),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          ExpandableTxnMetadata(txn, account),
          const SizedBox(height: 8),
          ExpandableTransferDetailsMetadata(txn: txn, linkedAccount: linkedAccount),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

class ExpandableTxnMetadata extends ConsumerWidget {
  const ExpandableTxnMetadata(this.txn, this.account, {super.key});

  final Transaction txn;
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(CupertinoIcons.creditcard),
            title: const Text(
              'Transaction Metadata',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'txn_id: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(text: txn.id, style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'acc_id: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(text: txn.accountId, style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'creator_id: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(text: txn.creatorUid, style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'txn_type: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.transactionType.typeAsString,
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'txn_date: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.transactionDate.toString(),
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'txn_amount: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.transactionAmount.toString(),
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'exchange_rate: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.exchangeRate.toString(),
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'base_currency: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.baseCurrency.code,
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'base_amount: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.baseAmount.toString(),
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'target_currency: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.targetCurrency?.code ?? 'null',
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'target_amount: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[200],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.fundDetails.targetAmount.toString(),
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class ExpandableTransferDetailsMetadata extends ConsumerWidget {
  const ExpandableTransferDetailsMetadata({
    required this.txn,
    required this.linkedAccount,
    super.key,
  });

  final Transaction txn;
  final Account linkedAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(Icons.compare_arrows),
            title: const Text(
              'Transfer Details Metadata',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'linked_account_id: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.transferDetails!.linkedAccountId,
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'linked_transaction_id: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.transferDetails!.linkedTransactionId,
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'transfer_description: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(
                              text: txn.transferDetails!.transferDescription.value ?? 'null',
                              style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'linked_account_name: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(text: linkedAccount.name, style: DefaultTextStyle.of(context).style),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
