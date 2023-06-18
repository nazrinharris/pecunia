import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_local_ds.g.dart';

@riverpod
AccountsLocalDS accountsLocalDS(AccountsLocalDSRef ref) => AccountsLocalDSImpl();

abstract interface class AccountsLocalDS {
  TaskEither<AccountsFailure, List<Account>> getAccounts();
  TaskEither<AccountsFailure, Account> createAccount({
    required String name,
    required String creatorId,
    required double initialBalance,
    required String currency,
    String? desc,
  });
}

class AccountsLocalDSImpl implements AccountsLocalDS {
  @override
  TaskEither<AccountsFailure, List<Account>> getAccounts() {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountsFailure, Account> createAccount(
      {required String name,
      required String creatorId,
      required double initialBalance,
      required String currency,
      String? desc}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }
}
