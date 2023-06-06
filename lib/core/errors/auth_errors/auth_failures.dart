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
AuthFailure mapSupabaseToFailure(AuthAction authAction, Object error, StackTrace stackTrace) {
  if (error is! supa.AuthException) {
    return UnknownAuthFailure(
      message: 'Unexpected error occurred, please try again.',
      stackTrace: stackTrace,
    );
  }

  switch (authAction) {
    case AuthAction.login:
      return LoginFailure(
        message: error.message,
        stackTrace: stackTrace,
        statusCode: error.statusCode,
      );
    case AuthAction.register:
      return RegisterFailure(
        message: error.message,
        stackTrace: stackTrace,
        statusCode: error.statusCode,
      );
    case AuthAction.logout:
      return LogoutFailure(
        message: error.message,
        stackTrace: stackTrace,
        statusCode: error.statusCode,
      );
  }
}
