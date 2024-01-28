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
  noInternet(
    'no-internet',
    "You don't seem to be connected to the internet, please try again later.",
  ),
  invalidCredentials(
    'invalid-credentials',
    'Your email or password are incorrect.',
  ),
  missingUsername(
    'missing-username',
    'Username is missing, please contact support.',
  ),
  noLoggedInUser(
    'no-logged-in-user',
    'No user is currently logged in.',
  ),
  cannotConvertToDTO(
    'cannot-convert-to-pecunia-user-dto',
    'Something went wrong while converting the PecuniaUser to a DTO.',
  ),
  cannotStoreSavedUser(
    'cannot-store-logged-in-user',
    'Something went wrong while storing the logged in user.',
  ),
  cannotRemoveSavedUser(
    'cannot-remove-logged-in-user',
    'Something went wrong while removing the logged in user.',
  ),
  cannotGetAllSavedUsers(
    'cannot-get-all-logged-in-users',
    'Something went wrong while getting all the logged in users.',
  ),
  failedStoreUserCredentials(
    'failed-store-user-credentials',
    'Something went wrong while storing the user credentials.',
  ),
  attemptedDeleteWithNoLoggedInUser(
    'attempted-delete-with-no-logged-in-user',
    'Attempted to delete a user with no logged in user. This should never happen.', // because all logged in users have a logged in user.
  ),
  attemptedMigrateUserWithNoLoggedInUser(
    'attempted-migrate-with-no-logged-in-user',
    'Attempted to migrate a user with no logged in user. This should never happen.', // because all logged in users have a logged in user.
  ),
  localFailedStoreSession(
    'local-failed-store-session',
    'Something went wrong while storing the session.',
  ),
  localFailedRegisterWithEmailAndPassword(
    'local-failed-register-with-email-and-password',
    'Something went wrong while registering with email and password.',
  ),
  localFailedGetSession(
    'local-failed-get-session',
    'Something went wrong while retrieving the local session.',
  ),
  localFailedRemoveSession(
    'local-failed-remove-session',
    'Something went wrong while removing the local session.',
  ),
  localFailedGetAllSessions(
    'local-failed-get-all-sessions',
    'Something went wrong while retrieving all the local sessions.',
  ),
  localFailedGetUserCredentials(
    'failed-get-user-credentials',
    'Something went wrong while getting the user credentials.',
  ),
  localFailedGetUserData(
    'local-failed-get-user-data',
    'Something went wrong while getting the user data.',
  ),
  localFailedMigrateUserFromUnknownToLocal(
    'local-failed-migrate-user-from-unknown-to-local',
    'Something went wrong while migrating the user from unknown to local.',
  ),
  localCannotFindUserData(
    'local-cannot-find-user-data',
    'Cannot find the user data.',
  ),
  localMissingHashedPassword(
    'local-missing-hashed-password',
    "Something went wrong while getting the user's credentials",
  ),
  localFailedDeleteUserDataAndCredentials(
    'local-failed-delete-user-data-and-credentials',
    'Something went wrong while deleting the user data and credentials.',
  ),
  localFailedSetLocalActiveSession(
    'local-failed-set-active-session',
    'Something went wrong while setting the local active session.',
  ),
  localFailedGetLocalActiveSession(
    'local-failed-get-local-active-session',
    'Something went wrong while getting the local active session.',
  ),
  localFailedRemoveLocalActiveSession(
    'local-failed-remove-local-active-session',
    'Something went wrong while removing the local active session.',
  ),
  localAttemptedDeleteLocalUserWithNoEmail(
    'local-attempted-delete-local-user-with-no-email',
    'Attempted to delete a local user with no email. This should never happen.', // because all local users have emails.
  ),
  localFailedDeleteUserDatabase(
    'local-failed-delete-user-database',
    'Something went wrong while deleting the user database.',
  ),
  incorrectCredentials(
    'incorrect-credentials',
    'Your email or password are incorrect.',
  ),
  unknown(
    defaultUnknownAuthErrorCode,
    defaultUnknownAuthErrorMessage,
  );

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
    @Default(AuthErrorType.unknown) AuthErrorType errorType,
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
    @Default(defaultUnknownAuthErrorMessage) String message,
    @Default(AuthErrorType.unknown) AuthErrorType? errorType,
    Object? rawException,
  }) = _UnknownAuthFailure;

  const factory AuthFailure.incorrectCredentials({
    required StackTrace stackTrace,
    required String message,
    @Default(AuthErrorType.incorrectCredentials) AuthErrorType? errorType,
    Object? rawException,
  }) = _IncorrectCredentialsAuthFailure;

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
