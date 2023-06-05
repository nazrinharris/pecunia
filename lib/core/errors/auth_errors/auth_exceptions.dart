import '../exceptions.dart';

// Auth Error Codes
const String noInternetErrorCode = 'no-internet';
const String invalidCredentialsErrorCode = 'invalid-credentials';
const String missingUserIdErrorCode = 'missing-user-id';
const String missingUsernameErrorCode = 'missing-username';
const String unknownAuthErrorCode = 'unknown-auth-error';

final class IncorrectCredentialsException extends BaseException {
  const IncorrectCredentialsException({
    String? errorCode,
    StackTrace? stackTrace,
  }) : super(
          message: "Incorrect email or password. Please try again.",
          errorCode: invalidCredentialsErrorCode,
          stackTrace: stackTrace,
        );
}

final class MissingUsernameException extends BaseException {
  const MissingUsernameException({
    String? errorCode,
    StackTrace? stackTrace,
  }) : super(
          message: "Username is missing. Please contact support.",
          errorCode: missingUsernameErrorCode,
          stackTrace: stackTrace,
        );
}

final class UnknownAuthException extends BaseException {
  const UnknownAuthException({
    String? errorCode,
    StackTrace? stackTrace,
  }) : super(
          message: "An unknown error occurred during authentication. Please try again.",
          errorCode: unknownAuthErrorCode,
          stackTrace: stackTrace,
        );
}
