// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/debug_dao.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/usecases/login_with_password.dart';
import 'package:pecunia/features/auth/usecases/register_with_password.dart';
import 'package:pecunia/presentation/screens/primary/accounts_screen.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Show a list of db stored in device
class DebugLocalDBScreen extends ConsumerWidget {
  const DebugLocalDBScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(createAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't create an account for you.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Account created successfully!',
              );
        }
      })
      ..listen(deleteAccountProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't delete your account.",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          ref.read(pecuniaDialogsProvider).showSuccessToast(
                context: context,
                title: 'Account deleted successfully!',
              );
        }
      });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Debug Local DB'),
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
                          context.pushNamed(
                            'drift-db-viewer',
                            extra: ref.read(pecuniaDBProvider).requireValue,
                          );
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonTheme(
                        minWidth: 0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 83, 10, 10)),
                          ),
                          onPressed: () async {
                            await ref.read(authRepoProvider).logout().run();
                            ref.read(loginWithEmailAndPasswordProvider.notifier).reset();
                            ref.read(registerWithEmailAndPasswordProvider.notifier).reset();
                            // ignore: use_build_context_synchronously
                            context.go('/start');
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ButtonTheme(
                        minWidth: 0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 83, 10, 10)),
                          ),
                          onPressed: () async {
                            await ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                                  title: 'Are you sure?',
                                  message:
                                      "Deleting the entries won't delete transactions or categories, but will delete all their relations",
                                  onConfirm: () async {
                                    await ref.read(debugDAOProvider).deleteAllTxnCategoriesEntries();
                                  },
                                  context: context,
                                );
                          },
                          child: const Text('Delete All Txn-Category Entries'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonTheme(
                        minWidth: 0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.orange[900]!.withOpacity(0.6)),
                          ),
                          onPressed: () async {
                            final shared = await SharedPreferences.getInstance();
                            await shared.setBool(kPrefsIsFirstOpen, true);
                            debugPrint('is_first_open set to true');
                          },
                          child: const Text('Reset is_first_open'),
                        ),
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
            const DebugFlutterSecureStorage(),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 14),
            const DebugLocalDatabases(),
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

Future<List<String>> getLocalDatabases() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final databases = await dbFolder.list().toList();

  return databases.map((file) => file.path).toList();
}

class DebugLocalDatabases extends ConsumerWidget {
  const DebugLocalDatabases({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Align(
          child: Text(
            'Local Databases',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder(
            future: getLocalDatabases(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                debugPrint('snapshot.data: ${snapshot.data}');
                final databases = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: databases.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      databases[index],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}

class DebugFlutterSecureStorage extends HookConsumerWidget {
  const DebugFlutterSecureStorage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final storage = ref.watch(pecuniaFlutterSecureStorageProvider).requireValue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          const Align(
            child: Text(
              'flutter_secure_storage test',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Storing this string at key: debug',
              hintText: 'Enter something',
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await storage.write(key: 'debug', value: textController.value.text);
                },
                child: const Text('Write'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  await storage.delete(key: 'debug');
                },
                child: const Text('Delete'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () async {
              final value = await storage.read(key: 'debug');
              textController.text = value ?? '';
            },
            child: const Text('Read (replaces the value in text field with stored value)'),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
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
            'dialogs and toast test',
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
                  ref.read(pecuniaDialogsProvider).showDebugPositionedDialog(context);
                },
                child: const Text('Show Positioned Dialog'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 61, 14, 11)),
                ),
                onPressed: () {
                  ref.read(pecuniaDialogsProvider).showFailureToast(
                      context: context,
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
                  ref.read(pecuniaDialogsProvider).showSuccessToast(
                      context: context,
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
        const SizedBox(height: 14),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 2, 33)),
          ),
          onPressed: () {
            context.pushNamed('debug-dialog');
          },
          child: const Text('Navigate to /debug-dialog'),
        ),
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
