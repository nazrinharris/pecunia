// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_local_db_provider.g.dart';

@riverpod
class CreateAccount extends _$CreateAccount {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> createAccount({
    required String name,
    required double initialBalance,
    required String currency,
    String? description,
  }) async {
    state = const AsyncValue.loading();

    debugPrint('retrieving logged in user...');
    final failureOrPecuniaUser = await ref.read(authRepoProvider).getLoggedInUser().run();

    final pecuniaUser = failureOrPecuniaUser.fold(
      (failure) {
        state = AsyncValue.error(failure, failure.stackTrace);
      },
      (pecuniaUser) => pecuniaUser,
    );

    if (pecuniaUser != null) {
      debugPrint('user exists, creating account...');
      final failureOrUnit = await ref
          .read(accountsRepoProvider)
          .createAccount(
            name: name,
            creatorUid: pecuniaUser.uid,
            initialBalance: initialBalance,
            currency: currency,
            desc: description,
          )
          .run()
        ..fold(
          (l) => state = AsyncError(l, l.stackTrace),
          (r) => state = AsyncData(Option.of(r)),
        );
    }
  }
}
