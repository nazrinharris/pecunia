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
const defaultUnknownAccountErrorMessage = 'Something went wrong, please try again.';

enum AccountsErrorType {
  unknown(defaultUnknownAccountErrorCode, defaultUnknownAccountErrorMessage);

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

AccountsFailure mapDriftToFailure(AccountsAction accountsAction, Object error, StackTrace stackTrace) {
  print(error.runtimeType);
  if (error is DriftRemoteException && error.remoteCause is SqliteException) {
    final cause = error.remoteCause as SqliteException;
    return AccountsFailure(
      accountsAction: accountsAction,
      errorType: AccountsErrorType.unknown,
      message: '${cause.message} \n${cause.causingStatement}',
      stackTrace: stackTrace,
      rawException: error,
    );
  } else {
    return AccountsFailure.unknown(
      stackTrace: stackTrace,
      message: AccountsErrorType.unknown.message,
      accountsAction: accountsAction,
      rawException: error,
    );
  }
}
