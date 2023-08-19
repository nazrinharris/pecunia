import 'package:flutter/foundation.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_accounts.g.dart';

@riverpod
class GetAllAccounts extends _$GetAllAccounts {
  @override
  Future<List<Account>> build() async {
    return _getAllAccounts();
  }

  Future<List<Account>> _getAllAccounts() async {
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
      debugPrint('user exists, retrieving accounts...');
      return (await ref.read(accountsRepoProvider).getAccounts().run()).fold(
        (l) => Future<List<Account>>.error(l, l.stackTrace),
        (r) => r,
      );
    } else {
      return Future<List<Account>>.error(
        AccountsFailure.unknown(
          stackTrace: StackTrace.current,
          message: 'This should never happen, please contact support.',
          accountsAction: AccountsAction.unknown,
        ),
        StackTrace.current,
      );
    }
  }
}
