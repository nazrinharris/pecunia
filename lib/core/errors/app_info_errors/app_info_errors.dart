import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:stack_trace/stack_trace.dart';

part 'app_info_errors.freezed.dart';

/// ****************************************************************
/// * AppInfo Error Definitions
/// * [AppInfoErrorType] - Enum of all possible app info errors
/// ****************************************************************

const defaultUnknownAppInfoErrorCode = 'unknown_app_info_error';
const defaultUnknownAppInfoErrorMessage = 'An unknown error occurred while fetching app info';

enum AppInfoErrorType {
  unknown(defaultUnknownAppInfoErrorCode, defaultUnknownAppInfoErrorMessage),
  errorGettingSharedPrefs('error_getting_shared_prefs', 'An error occurred while getting shared preferences');

  const AppInfoErrorType(this.code, this.message);

  final String code;
  final String message;

  static AppInfoErrorType fromErrorCode(String errorCode) {
    return AppInfoErrorType.values.firstWhere(
      (element) => element.code == errorCode,
      orElse: () => AppInfoErrorType.unknown,
    );
  }
}

/// ****************************************************************
/// * AppInfoFailure
/// ****************************************************************
@freezed
class AppInfoFailure with _$AppInfoFailure implements Failure {
  const factory AppInfoFailure({
    required StackTrace stackTrace,
    required String message,
    required AppInfoErrorType errorType,
    Object? rawException,
  }) = _AppInfoFailure;

  const AppInfoFailure._();

  const factory AppInfoFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    @Default(AppInfoErrorType.unknown) AppInfoErrorType errorType,
    Object? rawException,
  }) = _UnknownAppInfoFailure;

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
/// * AppInfoException
/// ****************************************************************
@freezed
class AppInfoException with _$AppInfoException implements Exception {
  factory AppInfoException({
    required StackTrace stackTrace,
    required AppInfoErrorType errorType,
    String? message,
  }) = _AppInfoException;

  AppInfoException._();

  factory AppInfoException.unknown({
    required StackTrace stackTrace,
    required AppInfoErrorType errorType,
    String? message,
  }) = _UnknownAppInfoException;

  factory AppInfoException.fromFailure(AppInfoFailure failure) {
    return AppInfoException(
      stackTrace: failure.stackTrace,
      errorType: failure.errorType,
      message: failure.message,
    );
  }

  factory AppInfoException.fromGenericFailure(Failure failure) {
    return AppInfoException(
      stackTrace: failure.stackTrace,
      errorType: AppInfoErrorType.unknown,
      message: failure.message,
    );
  }
}
