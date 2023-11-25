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
  return AuthRepo(
    authRemoteDS: ref.watch(authRemoteDSProvider),
    authLocalDS: ref.watch(authLocalDSProvider),
  );
}

typedef PecuniaUserAndSession = ({PecuniaUser user, Session session});

class AuthRepo {
  AuthRepo({
    required this.authRemoteDS,
    required this.authLocalDS,
  });

  final AuthRemoteDS authRemoteDS;
  final AuthLocalDS authLocalDS;

  TaskEither<AuthFailure, PecuniaUserAndSession> loginWithPassword({
    required String email,
    required String password,
  }) {
    return authRemoteDS.loginWithPassword(email: email, password: password).flatMap(
          (r) => authLocalDS.storeSavedUser(PecuniaUser.fromDTO(r.pecuniaUserDTO)).map(
                (_) => (user: PecuniaUser.fromDTO(r.pecuniaUserDTO), session: r.newSession),
              ),
        );
  }

  TaskEither<AuthFailure, PecuniaUserAndSession> localLoginWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      authLocalDS.loginWithEmailAndPassword(email: email, password: password).flatMap(
            (r) => authLocalDS.storeSavedUser(r.user).map((_) => r),
          );

  TaskEither<AuthFailure, PecuniaUserAndSession> localRegisterWithEmailAndPassword({
    required String email,
    required String username,
    required String password,
  }) =>
      authLocalDS
          .registerWithEmailAndPassword(
            email: email,
            password: password,
            username: username,
          )
          .flatMap(
            (r) => authLocalDS.storeSavedUser(r.user).map((_) => r),
          );

  TaskEither<AuthFailure, PecuniaUserAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
  }) {
    return authRemoteDS
        .registerWithPassword(
          username: username,
          email: email,
          password: password,
        )
        .flatMap(
          (r) => authLocalDS.storeSavedUser(PecuniaUser.fromDTO(r.pecuniaUserDTO)).map(
                (_) => (user: PecuniaUser.fromDTO(r.pecuniaUserDTO), session: r.newSession),
              ),
        );
  }

  // TODO: Implement logout for both local and remote
  TaskEither<AuthFailure, Unit> logout(String uid) {
    throw UnimplementedError();
  }

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    return authRemoteDS.getLoggedInUser();
  }
}
