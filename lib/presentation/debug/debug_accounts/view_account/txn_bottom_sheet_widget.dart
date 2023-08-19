import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/transfer_txn_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/debug/debug_forms/edit_txn_form_widget.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class TxnBottomSheet extends ConsumerWidget {
  const TxnBottomSheet(this.txn, this.account, {super.key});

  final Transaction txn;
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sign = txn.fundDetails.transactionType == TransactionType.credit ? '+' : '-';

    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Column(
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
                        text: txn.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        children: [
                          TextSpan(
                            text: '\nwith amount of ',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                          ),
                          TextSpan(
                            text: '$sign${txn.fundDetails.baseAmount} ${txn.fundDetails.baseCurrency.code}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: txn.fundDetails.transactionType == TransactionType.credit
                                      ? Colors.green[300]
                                      : Colors.red[300],
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
          TxnListTile(
            account: account,
            txn: txn,
            hideAccountName: true,
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
                      ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                            title: 'Delete transaction?',
                            message: "This isn't a reversible action, think twice.",
                            onConfirm: () {
                              ref.read(deleteTransactionProvider.notifier).deleteTransaction(txn);
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
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

void showTransactionBottomSheet(BuildContext context, Transaction txn, Account account) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      builder: (context) {
        return SizedBox(
          height: 550,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: TxnBottomSheet(txn, account),
          ),
        );
      });
}

void showEditTransactionBottomSheet(BuildContext context, Transaction txn, Account account) {
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
          child: Column(
            children: [
              EditTxnForm(txn: txn, account: account),
            ],
          ),
        );
      });
}

class BuildTxnAmountText extends ConsumerWidget {
  const BuildTxnAmountText(this.txn, {super.key});

  final Transaction txn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCredit = txn.fundDetails.transactionType == TransactionType.credit;
    final isMultiCurrency = txn.fundDetails.isMultiCurrency;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCredit)
              Text(
                '+${txn.fundDetails.transactionAmount}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (!isCredit)
              Text(
                '-${txn.fundDetails.transactionAmount}',
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(width: 10),
            Text(
              txn.fundDetails.transactionCurrency.code,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (isMultiCurrency) const SizedBox(height: 4),
        if (isMultiCurrency)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCredit)
                Text(
                  '+${txn.fundDetails.exchangedAmount}',
                  style: TextStyle(
                    color: Colors.green[300]!.withOpacity(0.3),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isCredit)
                Text(
                  '-${txn.fundDetails.exchangedAmount}',
                  style: TextStyle(
                    color: Colors.red[300]!.withOpacity(0.3),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                txn.fundDetails.exchangedCurrency.code,
                style: TextStyle(
                  color: Colors.grey[600]!.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
