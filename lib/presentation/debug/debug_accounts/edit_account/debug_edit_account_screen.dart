import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/presentation/debug/debug_accounts/edit_account/debug_edit_account_providers.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebugEditAccountScreen extends ConsumerWidget {
  const DebugEditAccountScreen(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(editAccountProvider, (prev, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureDialog(
              title: 'Something went wrong while editing your account.',
              failure: next.error as AccountsFailure?,
            );
      }

      if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
        ref.read(pecuniaDialogsProvider).showSuccessDialog(
              title: 'Your account has been edited!',
            );
        context.pop();
      }
    });

    final formGroup = ref.watch(editAccountFormProvider(
      name: account.name,
      description: account.description,
      currency: account.currency,
      initialBalance: account.initialBalance.toString(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing your account'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ReactiveForm(
              formGroup: formGroup,
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => formGroup.focus('description'),
                    decoration: const InputDecoration(
                      labelText: 'Account Name',
                      hintText: 'What name do you want to give to this account?',
                    ),
                  ),
                  ReactiveTextField<String>(
                    formControlName: 'description',
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      if (formGroup.value['description'] == '') {
                        formGroup.value['description'] = null;
                      }
                      formGroup.focus('currency');
                    },
                    decoration: const InputDecoration(
                        labelText: 'Description', hintText: 'You could also leave this empty.'),
                  ),
                  ReactiveDropdownField<String>(
                    formControlName: 'currency',
                    onChanged: (_) => formGroup.focus('initialBalance'),
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
                            ? () => ref.read(editAccountProvider.notifier).editAccount(
                                  oldAccount: account,
                                  name: form.value['name']! as String,
                                  description: form.value['description'] as String?,
                                  initialBalance: double.parse(form.value['initialBalance']! as String),
                                  currency: form.value['currency']! as String,
                                )
                            : null,
                        child: const Text('Save changes'),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
