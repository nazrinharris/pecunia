import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/accounts/usecases/watch_accounts.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class DebugLocalDBScreen extends ConsumerWidget {
  const DebugLocalDBScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(createAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't create an account for you.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Account created successfully!',
              );
        }
      })
      ..listen(deleteAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't delete your account.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Account deleted successfully!',
              );
        }
      });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Debug Local DB'),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 14),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed('drift-db-viewer', extra: ref.read(pecuniaDBProvider));
                        },
                        child: const Text('Inspect DB'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple[900]),
                        ),
                        onPressed: () {
                          ref.watch(getAllAccountsProvider);
                          context.pushNamed('debug-transactions');
                        },
                        child: const Text('Go to Debug Transactions'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.brown[900]),
                        ),
                        onPressed: () {
                          context.pushNamed('view-all-categories');
                        },
                        child: const Text('View All Categories'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 7),
            const DebugDialogsButtons(),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 14),
            const CreateAccountFormWidget(),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 14),
            const AccountsList(),
          ],
        ));
  }
}

class DebugDialogsButtons extends ConsumerWidget {
  const DebugDialogsButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Align(
          child: Text(
            'flutter_easy_dialogs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          alignment: Alignment.center,
          height: 50,
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showDebugPositionedDialog();
                },
                child: const Text('Show Positioned Dialog'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showDebugFullScreenDialog();
                },
                child: const Text('Show Full Screen Dialog'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 61, 14, 11)),
                ),
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showFailureDialog(
                          failure: AuthFailure(
                        stackTrace: StackTrace.current,
                        message: AuthErrorType.unknown.message,
                        errorType: AuthErrorType.unknown,
                      ));
                },
                child: const Text('Show Failure Screen Dialog'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 33, 1)),
                ),
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showSuccessDialog(
                      title: 'Account created successfully!',
                      message: 'You can check it out in the accounts tab.');
                },
                child: const Text('Show Success Screen Dialog'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 2, 33)),
                ),
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                      title: 'Are you sure?',
                      message: "This isn't reversible.",
                      onConfirm: () {},
                      context: context);
                },
                child: const Text('Show Confirmation Dialog'),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                context.pushNamed('debug-dialogs');
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[900])),
              child: const Text('Go to All Dialogs')),
        )
      ],
    );
  }
}

class CreateAccountFormWidget extends HookConsumerWidget {
  const CreateAccountFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final initialBalanceController = useTextEditingController();
    final currency = useState<Currency>(PecuniaCurrencies.myr);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey.value,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => descriptionController.text = '',
              decoration: const InputDecoration(
                labelText: 'Account Name',
                hintText: 'What name do you want to give to this account?',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                if (descriptionController.value.text == '') {
                  descriptionController.text = '';
                }
              },
              decoration: const InputDecoration(
                  labelText: 'Description', hintText: 'You could also leave this empty.'),
            ),
            Container(
              margin: const EdgeInsets.only(right: 14, left: 14, top: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Material(
                  color: Colors.transparent,
                  child: PopupMenuButton<Currency>(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    initialValue: currency.value,
                    onSelected: (Currency value) {
                      currency.value = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return PecuniaCurrencies.toList().map<PopupMenuItem<Currency>>((Currency c) {
                        return PopupMenuItem<Currency>(
                          value: c,
                          child: Text('${c.code} - ${c.name}', textAlign: TextAlign.center),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '${currency.value.code} - ${currency.value.name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: initialBalanceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Starting Balance',
                hintText: 'How much money do you have?',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                if (double.tryParse(value) == null || double.parse(value) < 0) {
                  return 'Please enter a value greater than or equal to 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (formKey.value.currentState!.validate()) {
                  ref.read(createAccountProvider.notifier).createAccount(
                        name: nameController.value.text,
                        initialBalance: double.parse(initialBalanceController.value.text),
                        currency: currency.value.code,
                        description: descriptionController.value.text,
                      );
                }
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountsList extends ConsumerWidget {
  const AccountsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(watchAccountsProvider);

    return Column(
      children: [
        const Align(
          child: Text(
            'All Accounts List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 14),
        stream.when(
          data: (failureOrList) => failureOrList.fold(
              (l) => Text(l.toString()),
              (list) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (ctx, index) => ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(list[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: list[index].description.value == null
                          ? null
                          : Text(
                              list[index].description.value!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '${list[index].currency.code} ${list[index].balance}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[100],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Handle edit action here
                              context.pushNamed('debug-edit-account', extra: list[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[300],
                            ),
                            onPressed: () {
                              // Handle delete action here
                              ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                                  title: 'Are you sure you want to delete this account?',
                                  message: 'This is irreversible',
                                  onConfirm: () {
                                    ref.read(deleteAccountProvider.notifier).deleteAccount(list[index]);
                                  },
                                  context: context);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.watch(getTransactionsByAccountIdProvider(list[index].id));

                        context.pushNamed('debug-view-account', extra: list[index]);
                      },
                    ),
                  )),
          error: (e, __) => Text(e.toString()),
          loading: () => const Align(child: CupertinoActivityIndicator()),
        )
      ],
    );
  }
}
