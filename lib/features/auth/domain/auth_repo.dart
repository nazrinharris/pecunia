import 'package:fpdart/fpdart.dart';

import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/models/session.dart';

typedef PecuniaUserAndSession = ({PecuniaUser pecuniaUser, Session session});

enum AuthAction { login, logout, register }

abstract interface class AuthRepo {
  TaskEither<Failure, PecuniaUserAndSession> loginWithPassword(
    String email,
    String password,
    Session currentSession,
  );

  TaskEither<Failure, PecuniaUserAndSession> registerWithPassword(
    String username,
    String email,
    String password,
    Session currentSession,
  );
}

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.authRemoteDS});
  final AuthRemoteDS authRemoteDS;

  @override
  TaskEither<Failure, PecuniaUserAndSession> loginWithPassword(
    String email,
    String password,
    Session currentSession,
  ) {
    return authRemoteDS
        .loginWithPassword(email: email, password: password, currentSession: currentSession)
        .flatMap(
          (r) => TaskEither.of(
            (pecuniaUser: PecuniaUser.fromDTO(r.pecuniaUserDTO), session: r.newSession),
          ),
        );
  }

  @override
  TaskEither<Failure, PecuniaUserAndSession> registerWithPassword(
      String username, String email, String password, Session currentSession) {
    // TODO: implement registerWithPassword
    throw UnimplementedError();
  }
}
