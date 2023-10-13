import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/watch_accounts.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:pecunia/presentation/screens/accounts/create_account_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/screens/shared/scale_button.dart';
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
                    itemBuilder: (ctx, index) {
                      ({bool isFirst, bool isLast})? position;

                      if (list.length == 1) {
                        position = (isFirst: true, isLast: true);
                      } else if (index == 0) {
                        position = (isFirst: true, isLast: false);
                      } else if (index == list.length - 1) {
                        position = (isFirst: false, isLast: true);
                      } else {
                        position = null;
                      }

                      return AccountListTile(list[index], position: position);
                    },
                  )),
          error: (e, __) => Text(e.toString()),
          loading: () => const Align(child: CupertinoActivityIndicator()),
        )
      ],
    );
  }
}

class AccountListTile extends ConsumerWidget {
  const AccountListTile(
    this.account, {
    this.position,
    super.key,
  });

  final Account account;
  final ({bool isFirst, bool isLast})? position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaleButton(
      onTap: () {
        ref.watch(getTransactionsByAccountIdProvider(account.id));
        context.pushNamed('debug-view-account', extra: account);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 4),
        shape: buildBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Row(
            children: [
              Text(
                account.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              const Spacer(),
              Text(
                '${account.currency.code} ${account.balance}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[100],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder buildBorder() {
    if (position != null) {
      if (position!.isFirst == true && position!.isLast == true) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        );
      } else if (position!.isFirst) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        );
      } else if (position!.isLast) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        );
      }
    }

    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
  }
}
