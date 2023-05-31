import '../../features/auth/data/auth_repository.dart';
import 'failures.dart';
import 'package:supabase/supabase.dart' as supa;

abstract class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    required super.stackTrace,
  });

  String get mapToErrorMessage {
    final failure = this;
    if (failure is LoginFailure) {
      return failure.message;
    } else if (failure is LogoutFailure) {
      return failure.message;
    }

    return "Unexpected error occurred, please try again.";
  }
}

class LoginFailure extends AuthFailure {
  const LoginFailure({
    required super.message,
    required super.stackTrace,
    this.statusCode,
  });

  final String? statusCode;
}

class LogoutFailure extends AuthFailure {
  const LogoutFailure({
    required super.message,
    required super.stackTrace,
    this.statusCode,
  });

  final String? statusCode;
}

class MissingUserIdLoginFailure extends AuthFailure {
  const MissingUserIdLoginFailure({
    required super.message,
    required super.stackTrace,
    this.statusCode,
  });

  final String? statusCode;
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure({
    required super.message,
    required super.stackTrace,
    this.statusCode,
  });

  final String? statusCode;
}

/// Supabase Specific Errors
///
AuthFailure mapSupabaseToFailure<T>(
    AuthAction authAction, Object error, StackTrace stackTrace) {
  if (error is! supa.AuthException) {
    return UnknownAuthFailure(
      message: "Unexpected error occurred, please try again.",
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
    case AuthAction.logout:
      return LogoutFailure(
        message: error.message,
        stackTrace: stackTrace,
        statusCode: error.statusCode,
      );
  }
}
