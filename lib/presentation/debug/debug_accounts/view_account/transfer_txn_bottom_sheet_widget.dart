import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
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
        children: [
          TransferTransactionListTile(account: account, txn: txn, enableBottomDivider: false),
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
              // TODO: Make transfer txn editing work
              showEditTransactionBottomSheet(context, txn, account);
            },
          ),
          ListTile(
            title: Text('Delete', style: TextStyle(color: Colors.red[300])),
            leading: Icon(Icons.delete, color: Colors.red[300]),
            onTap: () {
              // TODO: Make transfer txn deletion work
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
