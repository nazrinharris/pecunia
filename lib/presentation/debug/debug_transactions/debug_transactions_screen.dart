import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_txn_form_widget.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/recent_txn_list.dart';

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
          const RecentTxnList(),
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
