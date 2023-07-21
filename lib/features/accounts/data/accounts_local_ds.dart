import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'accounts_local_ds.g.dart';

@riverpod
AccountsLocalDS accountsLocalDS(AccountsLocalDSRef ref) => AccountsLocalDSImpl(
      accountsDAO: ref.watch(accountsDAOProvider),
      uuid: ref.watch(uuidProvider),
    );

abstract interface class AccountsLocalDS {
  TaskEither<AccountsFailure, List<AccountDTO>> getAccounts();
  TaskEither<AccountsFailure, AccountDTO> getAccountById(String id);
  Stream<Either<AccountsFailure, List<AccountDTO>>> watchAccounts();

  TaskEither<AccountsFailure, Unit> createAccount(AccountDTO accountDTO);

  TaskEither<AccountsFailure, Unit> updateAccountDetails(AccountDTO newAccountDetails);
  TaskEither<AccountsFailure, (bool isValid, double calculatedAmount)> validateAccountBalance(
      AccountDTO accountToRecalculate);

  TaskEither<AccountsFailure, Unit> deleteAccount(AccountDTO accountToDelete);
}

class AccountsLocalDSImpl implements AccountsLocalDS {
  AccountsLocalDSImpl({
    required this.accountsDAO,
    required this.uuid,
  });
  final AccountsDAO accountsDAO;
  final Uuid uuid;

  /// ******************************************************************************************************
  /// [getAccounts]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, List<AccountDTO>> getAccounts() {
    return accountsDAO.getAccounts();
  }

  /// ******************************************************************************************************
  /// [getAccountById]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, AccountDTO> getAccountById(String id) {
    return accountsDAO.getAccountById(id);
  }

  /// ******************************************************************************************************
  /// [watchAccounts]
  /// ******************************************************************************************************
  @override
  Stream<Either<AccountsFailure, List<AccountDTO>>> watchAccounts() {
    return accountsDAO.watchAllAccounts();
  }

  /// ******************************************************************************************************
  /// [createAccount]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> createAccount(AccountDTO account) {
    return accountsDAO.insertAccount(account);
  }

  /// ******************************************************************************************************
  /// [updateAccountDetails]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> updateAccountDetails(AccountDTO newAccountDetails) {
    return accountsDAO.updateAccount(newAccountDetails);
  }

  /// ******************************************************************************************************
  /// [deleteAccount]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, Unit> deleteAccount(AccountDTO accountToDelete) {
    return accountsDAO.deleteAccount(accountToDelete);
  }

  /// ******************************************************************************************************
  /// [validateAccountBalance]
  /// ******************************************************************************************************
  @override
  TaskEither<AccountsFailure, (bool, double)> validateAccountBalance(AccountDTO accountToRecalculate) {
    return accountsDAO.validateAccountBalance(accountToRecalculate);
  }
}
