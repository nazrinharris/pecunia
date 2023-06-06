import 'package:pecunia/core/errors/exceptions.dart';

// Auth Error Codes
const String noInternetErrorCode = 'no-internet';
const String invalidCredentialsErrorCode = 'invalid-credentials';
const String missingUserIdErrorCode = 'missing-user-id';
const String missingUsernameErrorCode = 'missing-username';
const String unknownAuthErrorCode = 'unknown-auth-error';

final class IncorrectCredentialsException extends BaseException {
  const IncorrectCredentialsException({
    super.stackTrace,
  }) : super(
          message: 'Incorrect email or password. Please try again.',
          errorCode: invalidCredentialsErrorCode,
        );
}

final class MissingUsernameException extends BaseException {
  const MissingUsernameException({
    super.stackTrace,
  }) : super(
          message: 'Username is missing. Please contact support.',
          errorCode: missingUsernameErrorCode,
        );
}

final class UnknownAuthException extends BaseException {
  const UnknownAuthException({
    super.stackTrace,
  }) : super(
          message: 'An unknown error occurred during authentication. Please try again.',
          errorCode: unknownAuthErrorCode,
        );
}
