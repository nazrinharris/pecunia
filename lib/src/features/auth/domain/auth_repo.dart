import 'package:fpdart/fpdart.dart';
import 'package:pecunia/src/features/auth/domain/pecunia_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/auth_failures.dart';

enum AuthAction {
  login,
  logout,
}

abstract interface class AuthRepo {
  TaskEither<AuthFailure, String> loginWithPassword(String email, String password);

  TaskEither<AuthFailure, String> registerWithPassword(String email, String password);

  TaskEither<AuthFailure, PecuniaUser> getUserInformation();

  TaskEither<AuthFailure, Unit> logout();
}

class AuthRepoImpl implements AuthRepo {
  final SupabaseClient supabaseClient;

  AuthRepoImpl(this.supabaseClient);

  @override
  TaskEither<AuthFailure, String> loginWithPassword(
    String email,
    String password,
  ) =>
      TaskEither.tryCatch(
        () async => await supabaseClient.auth.signInWithPassword(email: email, password: password),
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      ).map((response) => response.user?.id).flatMap(
            (uid) => TaskEither.fromNullable(
              uid,
              () => MissingUserIdLoginFailure(
                message: "Missing user id after login",
                stackTrace: StackTrace.current,
              ),
            ),
          );

  @override
  TaskEither<AuthFailure, PecuniaUser> getUserInformation() {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  TaskEither<AuthFailure, Unit> logout() => TaskEither.tryCatch(
        () async => await supabaseClient.auth.signOut().then((_) => unit),
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.logout, error, stackTrace),
      );

  @override
  TaskEither<AuthFailure, String> registerWithPassword(String email, String password) {
    // TODO: implement registerWithPassword

    throw UnimplementedError();
  }
}
