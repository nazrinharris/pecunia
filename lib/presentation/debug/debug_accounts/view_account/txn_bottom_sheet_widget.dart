import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/presentation/debug/debug_forms/edit_txn_form_widget.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class TxnBottomSheet extends ConsumerWidget {
  const TxnBottomSheet(this.txn, this.account, {super.key});

  final Transaction txn;
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Column(
        children: [
          ListTile(
            title: Text(
              txn.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: txn.transactionDescription.value == null
                ? null
                : Text(
                    txn.transactionDescription.value!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            trailing: BuildTxnAmountText(txn),
          ),
          const Divider(),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                          text: txn.transactionDate.toString(), style: DefaultTextStyle.of(context).style),
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
                          text: txn.fundDetails.baseCurrency.code, style: DefaultTextStyle.of(context).style),
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
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Edit'),
            leading: const Icon(Icons.edit),
            onTap: () {
              context.pop();
              showEditTransactionBottomSheet(context, txn, account);
            },
          ),
          ListTile(
            title: Text('Delete', style: TextStyle(color: Colors.red[300])),
            leading: Icon(Icons.delete, color: Colors.red[300]),
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
          ),
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
