import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/data/accounts_local_ds.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_repo.g.dart';

enum AccountsAction {
  getAccounts,
  watchAccounts,
  createAccount,
  updateAccountDetails,
  deleteAccount,

  /// This is a special case. This is used to map an [Account] to an [AccountDTO]
  mapAccountToDTO,
}

@riverpod
AccountsRepo accountsRepo(AccountsRepoRef ref) => AccountsRepoImpl(
      accountsLocalDS: ref.watch(accountsLocalDSProvider),
      helper: AccountsRepoHelper(),
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

  TaskEither<AccountsFailure, Unit> updateAccountDetails(Account newAccountDetails);
  TaskEither<AccountsFailure, Unit> deleteAccount(Account accountToDelete);
}

class AccountsRepoImpl implements AccountsRepo {
  AccountsRepoImpl({required this.accountsLocalDS, required this.helper});

  final AccountsLocalDS accountsLocalDS;
  final AccountsRepoHelper helper;

  @override
  TaskEither<AccountsFailure, List<Account>> getAccounts() {
    return accountsLocalDS.getAccounts().map((listOfDTOs) => listOfDTOs.map(Account.fromDTO).toList());
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

  @override
  TaskEither<AccountsFailure, Unit> updateAccountDetails(Account newAccountDetails) {
    return helper.mapAccountToDTO(newAccountDetails).flatMap(accountsLocalDS.updateAccountDetails);
  }

  @override
  TaskEither<AccountsFailure, Unit> deleteAccount(Account accountToDelete) {
    return helper.mapAccountToDTO(accountToDelete).flatMap(accountsLocalDS.deleteAccount);
  }
}

/// This class provides utility methods for the [AccountsRepo] class.
///
/// The [AccountsRepoHelper] class serves to simplify the [AccountsRepo] class by handling
/// specific tasks, such as converting [Account] objects to [AccountDTO].
///
/// It is designed to keep the code in [AccountsRepo] more clean and readable
/// by abstracting away some of the lower-level operations related to account data conversion.
class AccountsRepoHelper {
  /// Converts an [Account] object to an [AccountDTO] object.
  ///
  /// If the conversion is successful, it will return a [TaskEither] with the Right side containing the [AccountDTO].
  /// If an error occurs during the conversion, it will return a [TaskEither] with the Left side containing an [AccountsFailure].
  TaskEither<AccountsFailure, AccountDTO> mapAccountToDTO(Account account) {
    return TaskEither.tryCatch(
      () async => account.toDTO(),
      (error, stackTrace) => AccountsFailure(
        stackTrace: stackTrace,
        message: AccountsErrorType.cannotConvertToDTO.message,
        errorType: AccountsErrorType.cannotConvertToDTO,
        accountsAction: AccountsAction.mapAccountToDTO,
      ),
    );
  }
}
