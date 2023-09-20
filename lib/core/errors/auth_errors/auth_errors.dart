import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

part 'auth_errors.freezed.dart';

/// ****************************************************************
/// * Auth Error Definitions
/// * [AuthErrorType] - Enum of all possible auth errors
/// ****************************************************************

/// These are here because I cannot use the [AuthErrorType] enum to retrieve the
/// error message and code because they are not constant.
const defaultUnknownAuthErrorCode = 'unknown-auth-error';
const defaultUnknownAuthErrorMessage = 'Something went wrong during authentication, please try again.';
const defaultNoInternetMessage = 'No internet connection, please retry later.';

enum AuthErrorType {
  noInternet('no-internet', "You don't seem to be connected to the internet, please try again later."),
  invalidCredentials('invalid-credentials', 'Your email or password are incorrect.'),
  missingUsername('missing-username', 'Username is missing, please contact support.'),
  noLoggedInUser('no-logged-in-user', 'No user is currently logged in.'),
  cannotConvertToDTO('cannot-convert-to-pecunia-user-dto',
      'Something went wrong while converting the PecuniaUser to a DTO.'),
  unknown(defaultUnknownAuthErrorCode, defaultUnknownAuthErrorMessage);

  const AuthErrorType(this.code, this.message);

  final String code;
  final String message;

  static AuthErrorType fromErrorCode(String errorCode) {
    return AuthErrorType.values.firstWhere(
      (element) => element.code == errorCode,
      orElse: () => AuthErrorType.unknown,
    );
  }
}

/// ****************************************************************
/// * AuthException
/// ****************************************************************

@freezed
class AuthException with _$AuthException implements Exception {
  factory AuthException({
    required StackTrace stackTrace,
    required AuthErrorType errorType,
  }) = _AuthException;

  AuthException._();

  factory AuthException.unknown({
    required StackTrace stackTrace,
    required AuthErrorType errorType,
  }) = _UnknownAuthException;
}

/// ****************************************************************
/// * AuthFailure
/// ****************************************************************

@freezed
class AuthFailure with _$AuthFailure implements Failure {
  const factory AuthFailure({
    required StackTrace stackTrace,
    required String message,
    required AuthErrorType errorType,
    Object? rawException,
  }) = _AuthFailure;

  const AuthFailure._();

  const factory AuthFailure.noInternet({
    required StackTrace stackTrace,
    required String message,
    @Default(AuthErrorType.noInternet) AuthErrorType errorType,
    Object? rawException,
  }) = _NoInternetAuthFailure;

  const factory AuthFailure.unknown({
    required StackTrace stackTrace,
    required String message,
    @Default(AuthErrorType.unknown) AuthErrorType? errorType,
    Object? rawException,
  }) = _UnknownAuthFailure;

  @override
  List<Object> get props => [message, stackTrace];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    final terse = Trace.from(stackTrace).terse;
    return 'AuthFailure: $message \n$terse';
  }

  @override
  String toVerboseString() {
    return 'AuthFailure: $message \n$stackTrace \nRawException: $rawException';
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

AuthFailure mapSupabaseToFailure(Object error, StackTrace stackTrace) {
  if (error is AuthException) {
    return AuthFailure(
      errorType: error.errorType,
      message: error.errorType.message,
      stackTrace: stackTrace,
      rawException: error,
    );
  } else if (error is supa.AuthException) {
    return AuthFailure(
      errorType: AuthErrorType.unknown,
      message: error.message,
      stackTrace: stackTrace,
      rawException: error,
    );
  } else {
    return AuthFailure(
      errorType: AuthErrorType.unknown,
      message: AuthErrorType.unknown.message,
      stackTrace: stackTrace,
      rawException: error,
    );
  }
}
