import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/create_txn_form_widget.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/edit_txn_form_widget.dart';
import 'package:pecunia/presentation/debug/debug_transactions/providers/debug_transactions_provider.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class DebugTransactionsScreen extends ConsumerWidget {
  const DebugTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createTransactionProvider, (previous, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureDialog(
              title: 'Oopsies',
              failure: next.error as Failure?,
            );
      }
      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        ref.read(pecuniaDialogsProvider).showSuccessDialog(
              title: 'Transaction successfully created!',
            );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Transactions'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          const Divider(),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Create a Transaction',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          const CreateTransactionForm(),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'View All Transactions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 14),
          const ViewAllTransactions(),
        ],
      ),
    );
  }
}

class CreateTransactionForm extends HookConsumerWidget {
  const CreateTransactionForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsList = ref.watch(getAllAccountsProvider);
    return accountsList.when(
      data: (accounts) => CreateTxnForm(
        accountsList: accounts,
        initialTransactionType: TransactionType.credit,
        disableCloseButton: true,
      ),
      error: (f, stack) {
        final failure = f as Failure;
        return Center(
          child: Text(failure.toString()),
        );
      },
      loading: () => const Center(child: CupertinoActivityIndicator()),
    );
  }

  List<DropdownMenuItem<String>> buildAccountsDropdown(List<Account> accountsList) {
    final items = <DropdownMenuItem<String>>[];
    for (final account in accountsList) {
      items.add(
        DropdownMenuItem<String>(
          value: account.id,
          child: Text(
            account.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return items;
  }
}

class ViewAllTransactions extends ConsumerWidget {
  const ViewAllTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(getAllTransactionsProvider);
    final accountsList = ref.watch(getAllAccountsProvider);
    return transactionsList.when(
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
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          returnAccountName(
                              txn.accountId, accountsList.whenData((value) => value).asData?.value ?? []),
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
                      showTransactionBottomSheet(
                          context, txn, accountsList.whenData((value) => value).asData?.value ?? []);
                    },
                  ),
                  Divider(color: Colors.grey.withOpacity(0.1)),
                ],
              );
            },
          ),
        );
      },
      error: (err, s) {
        final except = err as TransactionsFailure;
        return Center(
          child: Text(except.message),
        );
      },
      loading: () => const Center(child: CupertinoActivityIndicator()),
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

class BuildTxnAmountText extends ConsumerWidget {
  const BuildTxnAmountText(this.txn, {super.key});

  final Transaction txn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCredit = txn.fundDetails.transactionType == TransactionType.credit;
    return Row(
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
          txn.fundDetails.transactionCurrency,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BottomSheetContent extends ConsumerWidget {
  const BottomSheetContent(this.txn, this.accountsList, this.account, {super.key});

  final Transaction txn;
  final List<Account> accountsList;
  final Account? account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(deleteTransactionProvider, (previous, next) {
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
      }
    });

    final chosenAccount = account ?? accountsList.firstWhere((element) => element.id == txn.accountId);

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
                      TextSpan(text: txn.fundDetails.baseCurrency, style: DefaultTextStyle.of(context).style),
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
                          text: txn.fundDetails.targetCurrency.toString(),
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
              showEditTransactionBottomSheet(context, txn, chosenAccount);
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

void showTransactionBottomSheet(BuildContext context, Transaction txn, List<Account> accountsList) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SizedBox(
          height: 550,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: BottomSheetContent(txn, accountsList, null),
          ),
        );
      });
}

void showEditTransactionBottomSheet(BuildContext context, Transaction txn, Account account) {
  showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SizedBox(
          height: 700,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                EditTxnForm(txn: txn, account: account),
              ],
            ),
          ),
        );
      });
}
