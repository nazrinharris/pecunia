import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';

import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class PecuniaFAB extends ConsumerWidget {
  const PecuniaFAB({super.key, this.fabKey});

  final GlobalKey<ExpandableFabState>? fabKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsValue = ref.watch(getAllAccountsProvider);

    return ExpandableFab(
      distance: 70,
      type: ExpandableFabType.up,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      children: [
        FloatingActionButton.extended(
          elevation: 3,
          heroTag: null,
          onPressed: () {
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
          tooltip: 'Add Income',
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          icon: const Icon(Icons.add),
          label: const Text('Income'),
        ),
        FloatingActionButton.extended(
          elevation: 3,
          heroTag: null,
          onPressed: () {
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
          tooltip: 'Add Expense',
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          icon: const Icon(Icons.remove),
          label: const Text('Expense'),
        ),
      ],
    );
  }
}
