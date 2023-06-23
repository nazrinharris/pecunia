import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/presentation/debug/debug_local_db/form/debug_create_account_form.dart';
import 'package:pecunia/presentation/debug/debug_local_db/providers/debug_local_db_provider.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('drift-db-viewer', extra: ref.read(pecuniaDBProvider));
                },
                child: const Text('Inspect DB'),
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
                        authAction: AuthAction.unknown,
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
                      );
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
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 15, 9, 49),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat),
                  SizedBox(width: 10),
                  Text('Visit All Dialogs'),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CreateAccountFormWidget extends ConsumerWidget {
  const CreateAccountFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ReactiveForm(
          formGroup: createAccountForm,
          child: Column(children: [
            ReactiveTextField<String>(
              formControlName: 'name',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => createAccountForm.focus('description'),
              decoration: const InputDecoration(
                labelText: 'Account Name',
                hintText: 'What name do you want to give to this account?',
              ),
            ),
            ReactiveTextField<String>(
              formControlName: 'description',
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                if (createAccountForm.value['description'] == '') {
                  createAccountForm.value['description'] = null;
                }
                createAccountForm.focus('currency');
              },
              decoration: const InputDecoration(
                  labelText: 'Description', hintText: 'You could also leave this empty.'),
            ),
            ReactiveDropdownField<String>(
              formControlName: 'currency',
              onChanged: (_) => createAccountForm.focus('initialBalance'),
              decoration: const InputDecoration(
                labelText: 'Currency',
                hintText: 'What currency should this account use?',
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: 'MYR',
                  child: Text('MYR - Malaysian Ringgit'),
                ),
                DropdownMenuItem<String>(
                  value: 'USD',
                  child: Text('USD - United States Dollar'),
                ),
              ],
            ),
            ReactiveTextField<String>(
              formControlName: 'initialBalance',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Starting Balance',
                hintText: 'How much money do you have?',
              ),
            ),
            const SizedBox(height: 16),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid
                      ? () => ref.read(createAccountProvider.notifier).createAccount(
                            name: form.value['name']! as String,
                            initialBalance: double.parse(form.value['initialBalance']! as String),
                            currency: form.value['currency']! as String,
                            description: form.value['description'] as String?,
                          )
                      : null,
                  child: const Text('Create Account'),
                );
              },
            )
          ])),
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
                      title: Text(list[index].name),
                      subtitle: list[index].description.value == null
                          ? null
                          : Text(
                              list[index].description.value!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '${list[index].currency} ${list[index].balance}',
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
                                  );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
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
