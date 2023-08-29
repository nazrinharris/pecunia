import 'package:drift/native.dart';
import 'package:drift/remote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:stack_trace/stack_trace.dart';

part 'categories_errors.freezed.dart';

/// ****************************************************************
/// * Categories Error Definitions
/// * [CategoriesErrorType] - Enum of all possible categories errors
/// ****************************************************************

/// These are here because I cannot use the [CategoriesErrorType] enum to retrieve the
/// error message and code because they are not constant.
const unknownCategoryErrorCode = 'unknown-category-error';
const unknownCategoryErrorMessage = "We're not sure what happened, please try again";

enum CategoriesErrorType {
  unknown(unknownCategoryErrorCode, unknownCategoryErrorMessage),
  sqliteException('sqlite-exception', 'Something went wrong while accessing the database.');

  const CategoriesErrorType(this.code, this.message);

  final String code;
  final String message;

  static CategoriesErrorType fromCode(String code) {
    return CategoriesErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => unknown,
    );
  }
}

/// ****************************************************************
/// * CategoriesException
/// ****************************************************************

@freezed
class CategoriesException with _$CategoriesException implements Exception {
  const factory CategoriesException({
    required StackTrace stackTrace,
    required CategoriesErrorType errorType,
    String? message,
  }) = _CategoriesException;

  factory CategoriesException.unknown({
    required StackTrace stackTrace,
    @Default(CategoriesErrorType.unknown) CategoriesErrorType errorType,
    String? message,
  }) = _UnknownCategoriesException;
}

/// ****************************************************************
/// * CategoriesFailure
/// ****************************************************************

@freezed
class CategoriesFailure with _$CategoriesFailure implements Failure {
  const factory CategoriesFailure({
    required StackTrace stackTrace,
    required String message,
    required CategoriesErrorType errorType,
    Object? rawException,
  }) = _CategoriesFailure;

  const CategoriesFailure._();

  const factory CategoriesFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    @Default(CategoriesErrorType.unknown) CategoriesErrorType errorType,
    Object? rawException,
  }) = _UnknownCategoriesFailure;

  factory CategoriesFailure.fromException(CategoriesException exception) {
    return CategoriesFailure(
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
    return 'CategoriesFailure: $message \n$terse';
  }

  @override
  String toVerboseString() {
    return 'CategoriesFailure: $message \n$stackTrace \nRawException: $rawException';
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

CategoriesFailure mapDriftToCategoriesFailure(Object error, StackTrace stackTrace) {
  if (error is DriftRemoteException && error.remoteCause is SqliteException) {
    final cause = error.remoteCause as SqliteException;
    return CategoriesFailure(
      errorType: CategoriesErrorType.sqliteException,
      message: '${cause.message} \n${cause.causingStatement}',
      stackTrace: stackTrace,
      rawException: error,
    );
  } else if (error is CategoriesException) {
    return CategoriesFailure(
        stackTrace: stackTrace,
        message: error.errorType.message,
        errorType: error.errorType,
        rawException: error);
  } else {
    return CategoriesFailure.unknown(
      stackTrace: stackTrace,
      message: CategoriesErrorType.unknown.message,
      rawException: error,
    );
  }
}
