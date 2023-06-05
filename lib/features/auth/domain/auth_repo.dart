import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../data/auth_remote_ds.dart';
import 'models/pecunia_user.dart';
import 'models/session.dart';

enum AuthAction {
  login,
  logout,
}

abstract interface class AuthRepo {
  Either<Failure, PecuniaUser> loginWithPassword(String email, String password, Session currentSession);
}

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDS authRemoteDS;

  AuthRepoImpl({required this.authRemoteDS});

  @override
  Either<Failure, PecuniaUser> loginWithPassword(
    String email,
    String password,
    Session currentSession,
  ) {
    final res = authRemoteDS
        .loginWithPassword(email: email, password: password, currentSession: currentSession)
        .run();

    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, PecuniaUser> getUserInformation() {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Unit> logout() {
    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, String> registerWithPassword(String email, String password) {
    // TODO: implement registerWithPassword

    throw UnimplementedError();
  }

  @override
  TaskEither<Failure, Session> updateSession(Session currentSession) {
    // TODO: implement updateSession
    throw UnimplementedError();
  }
}
