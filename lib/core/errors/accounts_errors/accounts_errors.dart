import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:stack_trace/stack_trace.dart';

part 'accounts_errors.freezed.dart';

/// ****************************************************************
/// * Accounts Error Definitions
/// * [AccountsErrorType] - Enum of all possible account errors
/// ****************************************************************

/// These are here because I cannot use the [AccountsErrorType] enum to retrieve the
/// error message and code because they are not constant.
const defaultUnknownAccountErrorCode = 'unknown-account-error';
const defaultUnknownAccountErrorMessage = "We're not sure what happened, please try again.";

enum AccountsErrorType {
  unknown(defaultUnknownAccountErrorCode, defaultUnknownAccountErrorMessage),
  cannotConvertToDTO(
      'cannot-convert-to-account-dto', 'Something went wrong while converting the Account to a DTO.'),
  sqliteException('sqlite-exception', 'Something went wrong while accessing the database.');

  const AccountsErrorType(this.code, this.message);

  final String code;
  final String message;

  static AccountsErrorType fromErrorCode(String errorCode) {
    return AccountsErrorType.values.firstWhere(
      (element) => element.code == errorCode,
      orElse: () => AccountsErrorType.unknown,
    );
  }
}

/// ****************************************************************
/// * AccountFailure
/// ****************************************************************

@freezed
class AccountsFailure with _$AccountsFailure implements Failure {
  const factory AccountsFailure({
    required StackTrace stackTrace,
    required String message,
    required AccountsAction accountsAction,
    required AccountsErrorType errorType,
    Object? rawException,
  }) = _AccountsFailure;

  const AccountsFailure._();

  const factory AccountsFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    required AccountsAction accountsAction,
    @Default(AccountsErrorType.unknown) AccountsErrorType errorType,
    Object? rawException,
  }) = _UnknownAccountsFailure;

  @override
  List<Object> get props => [message, stackTrace];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    final terse = Trace.from(stackTrace).terse;
    return 'AccountFailure: $message \n$terse';
  }

  @override
  String toVerboseString() {
    return 'AccountFailure: $message \n$stackTrace \nRawException: $rawException';
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

AccountsFailure mapDriftToAccountsFailure(
    AccountsAction accountsAction, Object error, StackTrace stackTrace) {
  switch (error) {
    case DriftRemoteException(remoteCause: SqliteException):
      final cause = error.remoteCause as SqliteException;
      return AccountsFailure(
        stackTrace: stackTrace,
        message: '${cause.message} \n${cause.causingStatement}',
        accountsAction: accountsAction,
        errorType: AccountsErrorType.sqliteException,
      );
    default:
      return AccountsFailure.unknown(
        stackTrace: stackTrace,
        message: AccountsErrorType.unknown.message,
        accountsAction: accountsAction,
        rawException: error,
      );
  }
}
