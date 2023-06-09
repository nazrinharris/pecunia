import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:stack_trace/stack_trace.dart';

part 'transactions_errors.freezed.dart';

/// ****************************************************************
/// * Transactions Error Definitions
/// * [TransactionsErrorType] - Enum of all possible transaction errors
/// ****************************************************************

/// These are here because I cannot use the [TransactionsErrorType] enum to retrieve the
/// error message and code because they are not constant.
const unknownTransactionErrorCode = 'unknown-transaction-error';
const unknownTransactionErrorMessage = "We're not sure what happened, please try again";

enum TransactionsErrorType {
  unknown(unknownTransactionErrorCode, unknownTransactionErrorMessage),
  cannotConvertToDTO(
      'cannot-convert-to-dto', 'Something went wrong while converting the transaction to a DTO'),
  sqliteException('sqlite-exception', 'Something went wrong while accessing the database'),
  invalidType('invalid-type', 'The transaction type is invalid'),
  transactionNotFound('transaction-not-found', 'The transaction was not found in the database');

  const TransactionsErrorType(this.code, this.message);

  final String code;
  final String message;

  static TransactionsErrorType fromErrorCode(String errorCode) {
    return TransactionsErrorType.values.firstWhere(
      (element) => element.code == errorCode,
      orElse: () => TransactionsErrorType.unknown,
    );
  }
}

/// ****************************************************************
/// * TransactionsException
/// ****************************************************************

@freezed
class TransactionsException with _$TransactionsException implements Exception {
  factory TransactionsException({
    required StackTrace stackTrace,
    required TransactionsErrorType errorType,
    required TransactionsAction transactionsAction,
  }) = _TransactionsException;

  TransactionsException._();

  factory TransactionsException.unknown({
    required StackTrace stackTrace,
    required TransactionsErrorType errorType,
  }) = _UnknownTransactionsException;

  factory TransactionsException.fromFailure(TransactionsFailure failure) {
    return TransactionsException(
      stackTrace: failure.stackTrace,
      errorType: failure.errorType,
      transactionsAction: failure.transactionsAction,
    );
  }
}

/// ****************************************************************
/// * TransactionsFailure
/// ****************************************************************

@freezed
class TransactionsFailure with _$TransactionsFailure implements Failure {
  const factory TransactionsFailure({
    required StackTrace stackTrace,
    required String message,
    required TransactionsAction transactionsAction,
    required TransactionsErrorType errorType,
    Object? rawException,
  }) = _TransactionsFailure;

  const TransactionsFailure._();

  const factory TransactionsFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    required TransactionsAction transactionsAction,
    @Default(TransactionsErrorType.unknown) TransactionsErrorType errorType,
    Object? rawException,
  }) = _UnknownTransactionsFailure;

  @override
  List<Object> get props => [message, stackTrace];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    final terse = Trace.from(stackTrace).terse;
    return 'TransactionsFailure: $message \n$terse';
  }

  @override
  String toVerboseString() {
    return 'TransactionsFailure: $message \n$stackTrace \nRawException: $rawException';
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

TransactionsFailure mapDriftToTransactionsFailure(
    TransactionsAction transactionsAction, Object error, StackTrace stackTrace) {
  if (error is DriftRemoteException && error.remoteCause is SqliteException) {
    final cause = error.remoteCause as SqliteException;
    return TransactionsFailure(
      transactionsAction: transactionsAction,
      errorType: TransactionsErrorType.sqliteException,
      message: '${cause.message} \n${cause.causingStatement}',
      stackTrace: stackTrace,
      rawException: error,
    );
  } else if (error is TransactionsException) {
    return TransactionsFailure(
      stackTrace: stackTrace,
      message: error.errorType.message,
      transactionsAction: transactionsAction,
      errorType: error.errorType,
    );
  } else {
    return TransactionsFailure.unknown(
      stackTrace: stackTrace,
      message: TransactionsErrorType.unknown.message,
      transactionsAction: transactionsAction,
      rawException: error,
    );
  }
}
