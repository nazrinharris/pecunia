import 'package:pecunia/core/errors/exceptions.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

base class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
  });

  String get mapToErrorMessage {
    final failure = this;
    if (failure is LoginFailure) {
      return failure.message;
    } else if (failure is LogoutFailure) {
      return failure.message;
    }

    return 'Unexpected error occurred, please try again.';
  }
}

final class LoginFailure extends AuthFailure {
  const LoginFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

final class LogoutFailure extends AuthFailure {
  const LogoutFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

final class RegisterFailure extends AuthFailure {
  const RegisterFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

final class MissingUserIdLoginFailure extends AuthFailure {
  const MissingUserIdLoginFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

final class MissingUsernameFailure extends AuthFailure {
  const MissingUsernameFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

final class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure({
    required super.message,
    required super.stackTrace,
    super.rawException,
    this.statusCode,
  });

  final String? statusCode;
}

/// Supabase Specific Errors
///
AuthFailure _handleAuthException(AuthAction authAction, String message, StackTrace stackTrace) {
  switch (authAction) {
    case AuthAction.login:
      return LoginFailure(
        message: message,
        stackTrace: stackTrace,
      );
    case AuthAction.register:
      return RegisterFailure(
        message: message,
        stackTrace: stackTrace,
      );
    case AuthAction.logout:
      return LogoutFailure(
        message: message,
        stackTrace: stackTrace,
      );
  }
}

AuthFailure mapSupabaseToFailure(AuthAction authAction, Object error, StackTrace stackTrace) {
  if (error is BaseException) {
    // Handle BaseException
    return _handleAuthException(authAction, error.message, stackTrace);
  } else if (error is supa.AuthException) {
    // Handle supa.AuthException
    return _handleAuthException(authAction, error.message, stackTrace);
  } else {
    // Handle other exceptions
    return UnknownAuthFailure(
      message: error.toString(), // Or another way to get a meaningful message from the error
      stackTrace: stackTrace,
    );
  }
}
