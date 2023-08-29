import 'package:drift/native.dart';
import 'package:drift/remote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:stack_trace/stack_trace.dart';

part 'txn_categories_errors.freezed.dart';

/// ****************************************************************
/// * TxnCategories Error Definitions
/// * [TxnCategoriesErrorType] - Enum of all possible TxnCategories errors
/// ****************************************************************

/// These are here because I cannot use the [TxnCategoriesErrorType] enum to retrieve the
/// error message and code because they are not constant.
const unknownTxnCategoryErrorCode = 'unknown-txn-category-error';
const unknownTxnCategoryErrorMessage = "We're not sure what happened, please try again";

enum TxnCategoriesErrorType {
  unknown(unknownTxnCategoryErrorCode, unknownTxnCategoryErrorMessage),
  sqliteException('sqlite-exception', 'Something went wrong while accessing the database.');

  const TxnCategoriesErrorType(this.code, this.message);

  final String code;
  final String message;

  static TxnCategoriesErrorType fromCode(String code) {
    return TxnCategoriesErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => unknown,
    );
  }
}

/// ****************************************************************
/// * TxnCategoriesException
/// ****************************************************************

@freezed
class TxnCategoriesException with _$TxnCategoriesException implements Exception {
  const factory TxnCategoriesException({
    required StackTrace stackTrace,
    required TxnCategoriesErrorType errorType,
    String? message,
  }) = _TxnCategoriesException;

  factory TxnCategoriesException.unknown({
    required StackTrace stackTrace,
    @Default(TxnCategoriesErrorType.unknown) TxnCategoriesErrorType errorType,
    String? message,
  }) = _UnknownTxnCategoriesException;
}

/// ****************************************************************
/// * TxnCategoriesFailure
/// ****************************************************************

@freezed
class TxnCategoriesFailure with _$TxnCategoriesFailure implements Failure {
  const factory TxnCategoriesFailure({
    required StackTrace stackTrace,
    required String message,
    required TxnCategoriesErrorType errorType,
    Object? rawException,
  }) = _TxnCategoriesFailure;

  const TxnCategoriesFailure._();

  const factory TxnCategoriesFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    @Default(TxnCategoriesErrorType.unknown) TxnCategoriesErrorType errorType,
    Object? rawException,
  }) = _UnknownTxnCategoriesFailure;

  factory TxnCategoriesFailure.fromException(TxnCategoriesException exception) {
    return TxnCategoriesFailure(
      stackTrace: exception.stackTrace,
      errorType: exception.errorType,
      message: exception.message ?? exception.errorType.message,
      rawException: exception,
    );
  }

  @override
  List<Object> get props => [message, stackTrace];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    final terse = Trace.from(stackTrace).terse;
    return 'TxnCategoriesFailure: $message \n$terse';
  }

  @override
  String toVerboseString() {
    return 'TxnCategoriesFailure: $message \n$stackTrace \nRawException: $rawException';
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

TxnCategoriesFailure mapDriftToTxnCategoriesFailure(Object error, StackTrace stackTrace) {
  if (error is DriftRemoteException && error.remoteCause is SqliteException) {
    final cause = error.remoteCause as SqliteException;
    return TxnCategoriesFailure(
      errorType: TxnCategoriesErrorType.sqliteException,
      message: '${cause.message} \n${cause.causingStatement}',
      stackTrace: stackTrace,
      rawException: error,
    );
  } else if (error is TxnCategoriesException) {
    return TxnCategoriesFailure(
        stackTrace: stackTrace,
        message: error.errorType.message,
        errorType: error.errorType,
        rawException: error);
  } else {
    return TxnCategoriesFailure.unknown(
      stackTrace: stackTrace,
      message: TxnCategoriesErrorType.unknown.message,
      rawException: error,
    );
  }
}
