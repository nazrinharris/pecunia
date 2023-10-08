import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class PecuniaFAB extends ConsumerWidget {
  const PecuniaFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsValue = ref.watch(getAllAccountsProvider);

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 14,
      overlayColor: Colors.black,
      overlayOpacity: 0.75,
      childrenButtonSize: const Size(68, 68),
      childMargin: const EdgeInsets.only(left: 18),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      activeBackgroundColor: Theme.of(context).colorScheme.errorContainer,
      activeForegroundColor: Theme.of(context).colorScheme.onErrorContainer,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          label: 'Add Income',
          labelBackgroundColor: Colors.transparent,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
          elevation: 0,
          labelShadow: [],
          shape: const CircleBorder(),
          onTap: () {
            switch (accountsValue) {
              case AsyncLoading():
                break;
              case AsyncError():
                ref.read(pecuniaDialogsProvider).showFailureDialog(
                      title: "Uh oh, can't create transaction...",
                      failure: accountsValue.error as Failure?,
                    );
              case AsyncData(:final value):
                showCreateTransactionBottomSheet(context, true, accountsList: value);
              case _:
                break;
            }
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.remove),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          label: 'Add Expense',
          labelBackgroundColor: Colors.transparent,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          elevation: 0,
          labelShadow: [],
          shape: const CircleBorder(),
          onTap: () {
            switch (accountsValue) {
              case AsyncLoading():
                break;
              case AsyncError():
                ref.read(pecuniaDialogsProvider).showFailureDialog(
                      title: "Uh oh, can't create transaction...",
                      failure: accountsValue.error as Failure?,
                    );
              case AsyncData(:final value):
                showCreateTransactionBottomSheet(context, false, accountsList: value);
              case _:
                break;
            }
          },
        ),
      ],
    );
  }
}