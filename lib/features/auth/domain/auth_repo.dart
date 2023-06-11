import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/models/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepoImpl(
    authRemoteDS: ref.watch(authRemoteDSProvider),
  );
}

typedef PecuniaUserAndSession = ({PecuniaUser pecuniaUser, Session session});

enum AuthAction { login, logout, register }

abstract interface class AuthRepo {
  TaskEither<Failure, PecuniaUserAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<Failure, PecuniaUserAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<Failure, Session> logout(Session currentSession);
}

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.authRemoteDS});
  final AuthRemoteDS authRemoteDS;

  @override
  TaskEither<Failure, PecuniaUserAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return authRemoteDS
        .loginWithPassword(email: email, password: password, currentSession: currentSession)
        .flatMap(
          (r) => TaskEither.of(
            (
              pecuniaUser: PecuniaUser.fromDTO(r.pecuniaUserDTO),
              session: r.newSession,
            ),
          ),
        );
  }

  @override
  TaskEither<Failure, PecuniaUserAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return authRemoteDS
        .registerWithPassword(
          username: username,
          email: email,
          password: password,
          currentSession: currentSession,
        )
        .flatMap(
          (r) => TaskEither.of(
            (
              pecuniaUser: PecuniaUser.fromDTO(r.pecuniaUserDTO),
              session: r.newSession,
            ),
          ),
        );
  }

  @override
  TaskEither<Failure, Session> logout(Session currentSession) {
    return authRemoteDS.logout(currentSession);
  }
}
