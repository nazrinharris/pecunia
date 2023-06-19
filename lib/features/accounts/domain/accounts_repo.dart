import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/data/accounts_local_ds.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_repo.g.dart';

enum AccountsAction {
  getAccounts,
  createAccount,
}

@riverpod
AccountsRepo accountsRepo(AccountsRepoRef ref) => AccountsRepoImpl(
      accountsLocalDS: ref.watch(accountsLocalDSProvider),
    );

abstract interface class AccountsRepo {
  TaskEither<AccountsFailure, List<Account>> getAccounts();
  Stream<Either<AccountsFailure, List<Account>>> watchAccounts();

  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  });
}

class AccountsRepoImpl implements AccountsRepo {
  AccountsRepoImpl({required this.accountsLocalDS});
  final AccountsLocalDS accountsLocalDS;

  @override
  TaskEither<AccountsFailure, List<Account>> getAccounts() {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }

  @override
  Stream<Either<AccountsFailure, List<Account>>> watchAccounts() {
    return accountsLocalDS.watchAccounts().map(
          (either) => either.fold(
            left,
            (listOfDTOs) => right(
              listOfDTOs.map(Account.fromDTO).toList(),
            ),
          ),
        );
  }

  @override
  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  }) {
    return accountsLocalDS.createAccount(
      name: name,
      creatorUid: creatorUid,
      initialBalance: initialBalance,
      currency: currency,
      desc: desc,
    );
  }
}
