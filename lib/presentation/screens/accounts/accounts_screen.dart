import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/watch_accounts.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:pecunia/presentation/screens/accounts/create_account_bottom_sheet_widget.dart';
import 'package:simple_animations/simple_animations.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

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
          context.pop();
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
        body: ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This is your',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      Text(
                        'Accounts List',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const AddAccountButton(),
                ],
              ),
              const SizedBox(height: 14),
              const AccountsList(),
            ],
          ),
        ),
      ],
    ));
  }
}

class AddAccountButton extends HookConsumerWidget {
  const AddAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = useState(Control.stop);

    return CustomAnimationBuilder(
      control: control.value,
      tween: MovieTween()
        ..tween(
          'scale',
          Tween<double>(begin: 1, end: 0.95),
          duration: const Duration(milliseconds: 100),
        )
        ..tween(
          'opacity',
          Tween<double>(begin: 1, end: 0.8),
          duration: const Duration(milliseconds: 100),
        ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Transform.scale(
        scale: value.get('scale'),
        child: Opacity(
          opacity: value.get('opacity'),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTapDown: (details) {
          control.value = Control.play;
        },
        onTapUp: (details) async {
          showCreateAccountBottomSheet(context);

          await HapticFeedback.lightImpact();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.playReverse;
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.stop;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'Add Account',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
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
                                  title: 'Delete this Account?',
                                  message: 'You will not be able to recover this account once deleted.',
                                  onConfirm: () async {
                                    await ref.read(deleteAccountProvider.notifier).deleteAccount(list[index]);
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
