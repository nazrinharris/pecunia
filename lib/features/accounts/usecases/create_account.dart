import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_account.g.dart';

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
        return;
      },
      (pecuniaUser) => pecuniaUser,
    );

    if (pecuniaUser != null && pecuniaUser.isSome()) {
      debugPrint('user exists, creating account...');
      (await ref
              .read(accountsRepoProvider)
              .createAccount(
                name: name,
                // TODO: Make better exception
                creatorUid: pecuniaUser.getOrElse(() => throw Exception()).uid,
                initialBalance: initialBalance,
                currency: currency,
                desc: description,
              )
              .run())
          .fold(
        (l) => state = AsyncError(l, l.stackTrace),
        (r) => state = AsyncData(Option.of(r)),
      );
    }
  }
}
