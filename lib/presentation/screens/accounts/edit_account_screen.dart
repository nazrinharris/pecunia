import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';

class EditAccountScreen extends HookConsumerWidget {
  const EditAccountScreen(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final nameController = useTextEditingController(text: account.name);
    final descriptionController = useTextEditingController(text: account.description.value);
    final initialBalanceController = useTextEditingController(text: account.initialBalance.toString());
    final currency = useState<Currency>(account.currency);
    final toolTipKey = GlobalKey<TooltipState>();

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
      body: Padding(
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
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        '${currency.value.code} - ${currency.value.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trailing: Tooltip(
                        key: toolTipKey,
                        triggerMode: TooltipTriggerMode.tap,
                        message: "You can't change the currency of an account",
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        showDuration: const Duration(seconds: 3),
                        child: const Icon(Icons.info_outline, color: Colors.grey),
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
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (formKey.value.currentState!.validate()) {
                    ref.read(editAccountProvider.notifier).editAccount(
                          oldAccount: account,
                          name: nameController.value.text,
                          initialBalance: double.parse(initialBalanceController.value.text),
                          description: descriptionController.value.text,
                        );
                  }
                },
                child: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
