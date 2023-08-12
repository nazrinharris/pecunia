import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transfer_transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

// TODO: Make transfer txn UI more "transfer transaction"-like
class TransferTxnBottomSheet extends ConsumerWidget {
  const TransferTxnBottomSheet(
    this.txn, {
    required this.account,
    required this.linkedAccount,
    super.key,
  });

  final Transaction txn;
  final Account account;
  final Account linkedAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      // TODO: Make transfer txn editing work
                      showEditTransactionBottomSheet(context, txn, account);
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
                            Icon(HeroIcons.pencil, color: Colors.purple[100]),
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
                      // TODO: Make transfer txn deletion work
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
                            Icon(HeroIcons.trash, color: Colors.red[100]),
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
            leading: const Icon(HeroIcons.credit_card),
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
                        text: 'linked_account_name: ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[300],
                            ),
                        children: <TextSpan>[
                          TextSpan(text: linkedAccount.name, style: DefaultTextStyle.of(context).style),
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
