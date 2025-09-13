import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
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
                (_) => (user: r.pecuniaUserDTO.toDomain(), session: r.newSession),
              ),
        );
  }

  // TODO: Implement logout for both local and remote
  TaskEither<AuthFailure, Unit> logout() {
    return authLocalDS.logout().flatMap(
          (localUser) => localUser.isNone() ? authRemoteDS.logout() : TaskEither.right(unit),
        );
  }

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    return authLocalDS.getLoggedInUser().flatMap(
          (localUser) => localUser.isNone() ? authRemoteDS.getLoggedInUser() : TaskEither.right(localUser),
        );
  }

  TaskEither<AuthFailure, List<PecuniaUser>> getSavedUsers() {
    return authLocalDS.getAllSavedUsers();
  }

  TaskEither<AuthFailure, Unit> deleteUserAccountAndData(PecuniaDriftDB db) {
    return authLocalDS.getLoggedInUser().flatMap(
      (maybeLocalUser) {
        return maybeLocalUser.fold(
          () => authRemoteDS.getLoggedInUser().flatMap((maybeRemoteUser) => maybeRemoteUser.fold(
                () => TaskEither.left(AuthFailure(
                  stackTrace: StackTrace.current,
                  message: AuthErrorType.attemptedDeleteWithNoLoggedInUser.message,
                  errorType: AuthErrorType.attemptedDeleteWithNoLoggedInUser,
                )),
                (remoteUser) => authRemoteDS.deleteRemoteUserAccount(remoteUser).flatMap(
                      (_) => authLocalDS.deleteAllRemoteUserData(remoteUser, db),
                    ),
              )),
          (localUser) => authLocalDS.deleteAllLocalUserData(localUser, db),
        );
      },
    );
  }

  TaskEither<AuthFailure, Unit> maybeMigratePecuniaUser() {
    return getLoggedInUser().flatMap(
      (maybeUser) => maybeUser.match(
        () => TaskEither.left(AuthFailure(
          stackTrace: StackTrace.current,
          message: AuthErrorType.attemptedMigrateUserWithNoLoggedInUser.message,
          errorType: AuthErrorType.attemptedMigrateUserWithNoLoggedInUser,
        )),
        _migrateIfUserTypeUnknown,
      ),
    );
  }

  /// This method should only be used in [maybeMigratePecuniaUser] as it expects a [PecuniaUser] to be present.
  ///
  /// [user] should also always technically be a local user. This is because [UserType.remote] is always present
  /// when [getLoggedInUser] returns a remote user. Specifically due to [AuthRemoteDSHelper.mapSupaUserToDTO] and
  /// [AuthRemoteDSHelper.mapSupaUserToDTOWithSession]
  TaskEither<AuthFailure, Unit> _migrateIfUserTypeUnknown(PecuniaUser user) {
    if (user.userType == UserType.unknown) {
      return authLocalDS.migrateUserFromUnknownToLocal(user);
    }
    return TaskEither.right(unit);
  }

  TaskEither<AuthFailure, PecuniaUser> continueAsGuest() {
    return authLocalDS.continueAsGuest().flatMap(
          (r) => authLocalDS.storeSavedUser(r).map((_) => r),
        );
  }
}
