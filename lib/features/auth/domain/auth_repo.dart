import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/auth_failures.dart';
import '../data/auth_remote_ds.dart';
import 'models/pecunia_user.dart';

enum AuthAction {
  login,
  logout,
}

abstract interface class AuthRepo {
  TaskEither<AuthFailure, String> loginWithPassword(String email, String password);

  TaskEither<AuthFailure, String> registerWithPassword(String email, String password);

  TaskEither<AuthFailure, PecuniaUser> getUserInformation();
  TaskEither<AuthFailure, Session> updateSession(Session currentSession);

  TaskEither<AuthFailure, Unit> logout();
}

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDS authRemoteDS;

  AuthRepoImpl({required this.authRemoteDS});

  @override
  TaskEither<AuthFailure, String> loginWithPassword(
    String email,
    String password,
  ) {
    throw UnimplementedError();
  }

  @override
  TaskEither<AuthFailure, PecuniaUser> getUserInformation() {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  TaskEither<AuthFailure, Unit> logout() {
    throw UnimplementedError();
  }

  @override
  TaskEither<AuthFailure, String> registerWithPassword(String email, String password) {
    // TODO: implement registerWithPassword

    throw UnimplementedError();
  }

  @override
  TaskEither<AuthFailure, Session> updateSession(Session currentSession) {
    // TODO: implement updateSession
    throw UnimplementedError();
  }
}
