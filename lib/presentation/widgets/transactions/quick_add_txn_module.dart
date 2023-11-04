// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/presentation/widgets/common/scale_button.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:pecunia/presentation/widgets/transactions/forms/create_txn_form_widget.dart';

class QuickAddTxnModule extends ConsumerWidget {
  const QuickAddTxnModule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsValue = ref.watch(getAllAccountsProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 7, left: 7),
                child: ScaleButton(
                  onTap: () {
                    switch (accountsValue) {
                      case AsyncLoading():
                        break;
                      case AsyncError():
                        ref.read(pecuniaDialogsProvider).showFailureToast(
                              context: context,
                              title: "Uh oh, can't create transaction...",
                              failure: accountsValue.error as Failure?,
                            );
                      case AsyncData(:final value) when value.isEmpty:
                        ref.read(pecuniaDialogsProvider).showFailureToast(
                              context: context,
                              title: "You don't have an account to add income to!",
                              failure: accountsValue.error as Failure?,
                            );
                      case AsyncData(:final value) when value.isNotEmpty:
                        showCreateTxnBottomSheet(context, true, accountsList: value);
                      case _:
                        break;
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.green[900]!.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.green[100], size: 32),
                          SizedBox(width: 4),
                          Text(
                            'Add income',
                            style: TextStyle(
                              color: Colors.green[100],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 7, bottom: 7, right: 7),
                child: ScaleButton(
                  onTap: () {
                    switch (accountsValue) {
                      case AsyncLoading():
                        break;
                      case AsyncError():
                        ref.read(pecuniaDialogsProvider).showFailureToast(
                              context: context,
                              title: "Uh oh, can't create transaction...",
                              failure: accountsValue.error as Failure?,
                            );
                      case AsyncData(:final value) when value.isEmpty:
                        ref.read(pecuniaDialogsProvider).showFailureToast(
                              context: context,
                              title: "You don't have an account to add expense to!",
                              failure: accountsValue.error as Failure?,
                            );
                      case AsyncData(:final value):
                        showCreateTxnBottomSheet(context, false, accountsList: value);
                      case _:
                        break;
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.red[900]!.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove, color: Colors.red[100], size: 32),
                          SizedBox(width: 4),
                          Text(
                            'Add expense',
                            style: TextStyle(
                              color: Colors.red[100],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
