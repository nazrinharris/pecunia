import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';

void showCreateAccountBottomSheet(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CreateAccountBottomSheet(),
              SizedBox(height: 64),
            ],
          ),
        ),
      );
    },
  );
}

class CreateAccountBottomSheet extends HookConsumerWidget {
  const CreateAccountBottomSheet({
    super.key,
    this.disableCloseButton = false,
  });

  final bool disableCloseButton;

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
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!disableCloseButton)
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                splashFactory: InkRipple.splashFactory,
              ),
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
