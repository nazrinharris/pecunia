import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/accounts/data/accounts_local_ds.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'accounts_repo.g.dart';

enum AccountsAction {
  getAccounts,
  getAccountById,
  watchAccounts,
  createAccount,
  updateAccountDetails,
  deleteAccount,

  recalculateAccountBalance,
  unknown,

  /// This is a special case. This is used to map an [Account] to an [AccountDTO]
  mapAccountToDTO,
}

@riverpod
AccountsRepo accountsRepo(AccountsRepoRef ref) => AccountsRepoImpl(
      accountsLocalDS: ref.watch(accountsLocalDSProvider),
      uuid: ref.watch(uuidProvider),
      helper: AccountsRepoHelper(),
    );

abstract interface class AccountsRepo {
  TaskEither<AccountsFailure, List<Account>> getAccounts();
  TaskEither<AccountsFailure, Account> getAccountById(String id);
  Stream<Either<AccountsFailure, List<Account>>> watchAccounts();

  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  });

  TaskEither<AccountsFailure, Unit> updateAccountDetails(Account newAccountDetails);
  TaskEither<AccountsFailure, (bool isValid, double calculatedAmount)> validateAccountBalance(
      Account accountToRecalculate);

  TaskEither<AccountsFailure, Unit> deleteAccount(Account accountToDelete);
}

class AccountsRepoImpl implements AccountsRepo {
  AccountsRepoImpl({
    required this.accountsLocalDS,
    required this.helper,
    required this.uuid,
  });

  final AccountsLocalDS accountsLocalDS;
  final AccountsRepoHelper helper;
  final Uuid uuid;

  /// ******************************************************************************************************
  /// [getAccounts]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, List<Account>> getAccounts() {
    return accountsLocalDS.getAccounts().map((listOfDTOs) => listOfDTOs.map(Account.fromDTO).toList());
  }

  /// ******************************************************************************************************
  /// [getAccountById]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Account> getAccountById(String id) {
    return accountsLocalDS.getAccountById(id).map(Account.fromDTO);
  }

  /// ******************************************************************************************************
  /// [watchAccounts]
  /// ******************************************************************************************************
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

  /// ******************************************************************************************************
  /// [createAccount]
  ///
  /// Using the arguments provided, we will first create the account using the [Account.newAccount] factory to
  /// essentially sanitise the data. Then we will map the [Account] to a [AccountDTO] using the [AccountsRepoHelper] class.
  /// Finally, we will use the [AccountsLocalDS] to create the account.
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  }) {
    return helper
        .mapAccountToDTO(Account.newAccount(
          creatorUid: creatorUid,
          name: name,
          initialBalance: initialBalance,
          currency: currency,
          createdOn: DateTime.now(),
          uuid: uuid,
          description: AccountDescription(desc),
        ))
        .flatMap(accountsLocalDS.createAccount);
  }

  /// ******************************************************************************************************
  /// [updateAccountDetails]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> updateAccountDetails(Account newAccountDetails) {
    return helper.mapAccountToDTO(newAccountDetails).flatMap(accountsLocalDS.updateAccountDetails);
  }

  /// ******************************************************************************************************
  /// [deleteAccount]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> deleteAccount(Account accountToDelete) {
    return helper.mapAccountToDTO(accountToDelete).flatMap(accountsLocalDS.deleteAccount);
  }

  /// ******************************************************************************************************
  /// [validateAccountBalance]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, (bool, double)> validateAccountBalance(Account accountToRecalculate) {
    return helper.mapAccountToDTO(accountToRecalculate).flatMap(accountsLocalDS.validateAccountBalance);
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
