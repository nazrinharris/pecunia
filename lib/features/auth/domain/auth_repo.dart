import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/features/auth/data/auth_local_ds.dart';
import 'package:pecunia/features/auth/data/auth_remote_ds.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepoImpl(
    authRemoteDS: ref.watch(authRemoteDSProvider),
    authLocalDS: ref.watch(authLocalDSProvider),
  );
}

abstract interface class AuthRepo {
  TaskEither<AuthFailure, PecuniaUserAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<AuthFailure, PecuniaUserAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser();

  TaskEither<AuthFailure, Session> logout(Session currentSession);
}

typedef PecuniaUserAndSession = ({PecuniaUser pecuniaUser, Session session});

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.authRemoteDS,
    required this.authLocalDS,
  });

  final AuthRemoteDS authRemoteDS;
  final AuthLocalDS authLocalDS;

  @override
  TaskEither<AuthFailure, PecuniaUserAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return authRemoteDS
        .loginWithPassword(email: email, password: password, currentSession: currentSession)
        .flatMap(
          (r) => authLocalDS.storeSavedUser(PecuniaUser.fromDTO(r.pecuniaUserDTO)).map(
                (_) => (pecuniaUser: PecuniaUser.fromDTO(r.pecuniaUserDTO), session: r.newSession),
              ),
        );
  }

  @override
  TaskEither<AuthFailure, PecuniaUserAndSession> registerWithPassword({
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
          (r) => authLocalDS.storeSavedUser(PecuniaUser.fromDTO(r.pecuniaUserDTO)).map(
                (_) => (pecuniaUser: PecuniaUser.fromDTO(r.pecuniaUserDTO), session: r.newSession),
              ),
        );
  }

  @override
  TaskEither<AuthFailure, Session> logout(Session currentSession) {
    return authRemoteDS.logout(currentSession);
  }

  @override
  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    return authRemoteDS.getLoggedInUser();
  }
}
