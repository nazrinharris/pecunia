// TODO: Remove ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';

class CreateTransferTxnFields {
  static String? validateTransferDescription(String? val) {
    if (val != null && val.length > 500) {
      return 'Please enter a description less than 500 characters';
    }
    return null;
  }
}

/// Providing a [defaultSourceAccount] disables the ability to change the `chosenSourceAccount`
class CreateTransferTxnForm extends HookConsumerWidget {
  const CreateTransferTxnForm({
    required this.defaultSourceAccount,
    required this.accountsList,
    super.key,
  });

  final Account? defaultSourceAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenSourceAccount = useState(defaultSourceAccount ?? accountsList.first);
    final chosenDestinationAccount = useState<Account?>(null);
    final formKey = useState(GlobalKey<FormState>());

    final accountsListValue = ref.watch(getAllAccountsProvider);

    return switch (accountsListValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final AccountsFailure error) => Center(child: Text(error.message)),
      AsyncData(value: final List<Account> accountsList) => accountsList.length != 1
          ? TransferFormContent(
              formKey.value,
              chosenSourceAccount,
              chosenDestinationAccount,
              accountsList,
            )
          : const Center(child: Text('You need at least 2 accounts to transfer money.')),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class TransferFormContent extends HookConsumerWidget {
  const TransferFormContent(
    this.formKey,
    this.chosenSourceAccount,
    this.chosenDestinationAccount,
    this.accountsList, {
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ValueNotifier<Account> chosenSourceAccount;
  final ValueNotifier<Account?> chosenDestinationAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transferDescriptionController = useTextEditingController();

    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transfer Transaction',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue[100],
                    ),
                  ),
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'From',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
                SizedBox(width: 8),
                Expanded(
                    child:
                        SourceAccountDropdown(chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'To',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_back),
                SizedBox(width: 8),
                Expanded(
                    child: DestinationAccountDropdown(
                        chosenSourceAccount, chosenDestinationAccount, accountsList)),
              ],
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: transferDescriptionController,
              decoration: const InputDecoration(
                labelText: "What's the transfer about?",
              ),
              validator: CreateTransferTxnFields.validateTransferDescription,
            ),
            SizedBox(height: 28),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // await ref.read(createTransferTransactionProvider.notifier).createTransferTransaction(
                  //       chosenSourceAccount.value,
                  //       chosenDestinationAccount.value!,
                  //       transferDescriptionController.text,
                  //     );
                  // context.go('/transactions');
                }
              },
              child: Text('Create Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceAccountDropdown extends HookConsumerWidget {
  const SourceAccountDropdown(this.chosenSourceAccount, this.chosenDestinationAccount, this.accountsList,
      {super.key});

  final ValueNotifier<Account> chosenSourceAccount;
  final ValueNotifier<Account?> chosenDestinationAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<Account>(
      isExpanded: true,
      value: chosenSourceAccount.value,
      onChanged: (Account? newSource) {
        if (chosenDestinationAccount.value != null && newSource!.id == chosenDestinationAccount.value!.id) {
          chosenDestinationAccount.value = chosenSourceAccount.value;
        }
        chosenSourceAccount.value = newSource!;
      },
      items: accountsList.map<DropdownMenuItem<Account>>((Account value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      hint: Text('Select Source Account'),
    );
  }
}

class DestinationAccountDropdown extends HookConsumerWidget {
  const DestinationAccountDropdown(this.chosenSourceAccount, this.chosenDestinationAccount, this.accountsList,
      {super.key});

  final ValueNotifier<Account> chosenSourceAccount;
  final ValueNotifier<Account?> chosenDestinationAccount;
  final List<Account> accountsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonFormField<Account>(
      isExpanded: true,
      value: chosenDestinationAccount.value,
      onChanged: (Account? newDestination) {
        if (newDestination!.id == chosenSourceAccount.value.id) {
          chosenSourceAccount.value = chosenDestinationAccount.value ??
              accountsList.firstWhere((account) => account.id != newDestination.id);
        }
        chosenDestinationAccount.value = newDestination;
      },
      items: accountsList.map<DropdownMenuItem<Account>>((Account value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      hint: Text('Select Destination Account'),
    );
  }
}
