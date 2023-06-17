import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/network_info/network_info.dart';
import 'package:pecunia/core/infrastructure/supabase/pecunia_supabase.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

part 'auth_remote_ds.g.dart';

@riverpod
AuthRemoteDS authRemoteDS(AuthRemoteDSRef ref) => SupabaseAuthRemoteDS(
      ref.watch(supabaseClientProvider),
      ref.watch(networkInfoProvider),
    );

typedef PecuniaUserDTOAndSession = ({PecuniaUserDTO pecuniaUserDTO, Session newSession});
typedef SupaUserAndSession = ({s.User user, Session newSession});
typedef AuthResponseAndSession = ({s.AuthResponse response, Session currentSession});

abstract interface class AuthRemoteDS {
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<AuthFailure, PecuniaUserDTOAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<AuthFailure, PecuniaUserDTO> getLoggedInUser();

  TaskEither<AuthFailure, Session> logout(Session currentSession);
}

class SupabaseAuthRemoteDS implements AuthRemoteDS {
  SupabaseAuthRemoteDS(this.supabaseClient, this.network);

  final s.SupabaseClient supabaseClient;
  final NetworkInfo network;

  @override
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    const currentAction = AuthAction.login;
    return network
        .isConnected()
        .mapLeft((l) => AuthFailure.unknown(
              authAction: currentAction,
              stackTrace: StackTrace.current,
              message: AuthErrorType.unknown.message,
            ))
        .flatMap<AuthResponseAndSession>(
          (isConnected) => isConnected
              ? _requestLoginWithPassword(
                  email: email,
                  password: password,
                  currentSession: currentSession,
                  authAction: currentAction,
                )
              : TaskEither.left(AuthFailure.noInternet(
                  authAction: currentAction,
                  message: AuthErrorType.noInternet.message,
                  stackTrace: StackTrace.current,
                )),
        )
        .flatMap((r) => SupabaseAuthRemoteDSHelper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
              currentAction,
            ))
        .flatMap((r) => SupabaseAuthRemoteDSHelper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
              currentAction,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> _requestLoginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
    required AuthAction authAction,
  }) =>
      TaskEither.tryCatch(
        () async {
          final response = await supabaseClient.auth.signInWithPassword(
            email: email,
            password: password,
          );
          return (response: response, currentSession: const Session(isValid: true));
        },
        (error, stackTrace) => mapSupabaseToFailure(authAction, error, stackTrace),
      );

  @override
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  }) {
    const currentAction = AuthAction.register;
    return network
        .isConnected()
        .mapLeft((l) => AuthFailure.unknown(
              authAction: currentAction,
              stackTrace: StackTrace.current,
              message: AuthErrorType.unknown.message,
            ))
        .flatMap<AuthResponseAndSession>(
          (isConnected) => isConnected
              ? _requestRegisterWithPassword(
                  username: username,
                  email: email,
                  password: password,
                  currentSession: currentSession,
                  authAction: currentAction,
                )
              : TaskEither.left(AuthFailure.noInternet(
                  authAction: currentAction,
                  message: AuthErrorType.noInternet.message,
                  stackTrace: StackTrace.current,
                )),
        )
        .flatMap((r) => SupabaseAuthRemoteDSHelper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
              currentAction,
            ))
        .flatMap((r) => SupabaseAuthRemoteDSHelper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
              currentAction,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> _requestRegisterWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
    required AuthAction authAction,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await supabaseClient.auth.signUp(
          email: email,
          password: password,
          data: {'username': username},
        );
        return (response: response, currentSession: const Session(isValid: true));
      },
      (error, stackTrace) {
        return mapSupabaseToFailure(authAction, error, stackTrace);
      },
    );
  }

  @override
  TaskEither<AuthFailure, Session> logout(Session currentSession) {
    const currentAction = AuthAction.logout;
    return network
        .isConnected()
        .mapLeft(
          (l) => AuthFailure.unknown(
            authAction: currentAction,
            stackTrace: StackTrace.current,
            message: AuthErrorType.unknown.message,
          ),
        )
        .flatMap<Session>(
          (isConnected) => isConnected
              ? _requestLogout(currentSession, currentAction)
              : TaskEither.left(AuthFailure.noInternet(
                  authAction: currentAction,
                  message: AuthErrorType.noInternet.message,
                  stackTrace: StackTrace.current,
                )),
        );
  }

  TaskEither<AuthFailure, Session> _requestLogout(Session currentSession, AuthAction authAction) {
    return TaskEither.tryCatch(
      () async {
        await supabaseClient.auth.signOut();
        return currentSession.copyWith(isValid: false);
      },
      (error, stackTrace) => mapSupabaseToFailure(authAction, error, stackTrace),
    );
  }

  @override
  TaskEither<AuthFailure, PecuniaUserDTO> getLoggedInUser() {
    const currentAction = AuthAction.getLoggedInUser;
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      return TaskEither.left(AuthFailure(
        authAction: currentAction,
        errorType: AuthErrorType.noLoggedInUser,
        stackTrace: StackTrace.current,
        message: AuthErrorType.noLoggedInUser.message,
      ));
    }
    return SupabaseAuthRemoteDSHelper.mapSupaUserToDTO(user, currentAction);
  }
}

/// ****************************************************************
/// * Helpers
/// ****************************************************************

class SupabaseAuthRemoteDSHelper {
  static TaskEither<AuthFailure, PecuniaUserDTO> mapSupaUserToDTO(
    s.User user,
    AuthAction authAction,
  ) =>
      TaskEither.tryCatch(
        () async {
          return PecuniaUserDTO(
            uid: user.id,
            email: user.email,
            username: user.userMetadata!['username'] as String,
            dateCreated: DateTime.parse(user.createdAt),
          );
        },
        (error, stackTrace) => mapSupabaseToFailure(authAction, error, stackTrace),
      );

  static TaskEither<AuthFailure, PecuniaUserDTOAndSession> mapSupaUserToDTOWithSession(
    s.User user,
    Session newSession,
    AuthAction authAction,
  ) =>
      TaskEither.tryCatch(
        () async {
          return (
            pecuniaUserDTO: PecuniaUserDTO(
              uid: user.id,
              email: user.email,
              username: user.userMetadata!['username'] as String,
              dateCreated: DateTime.parse(user.createdAt),
            ),
            newSession: newSession
          );
        },
        (error, stackTrace) => mapSupabaseToFailure(authAction, error, stackTrace),
      );

  static TaskEither<AuthFailure, SupaUserAndSession> getUserFromAuthResponse(
    s.AuthResponse response,
    Session newSession,
    AuthAction authAction,
  ) =>
      TaskEither.tryCatch(
        () async {
          final user = response.user;

          if (user == null || user.userMetadata?['username'] == null) {
            throw AuthException(
              authAction: authAction,
              errorType: AuthErrorType.missingUsername,
              stackTrace: StackTrace.current,
            );
          }
          return (user: user, newSession: newSession);
        },
        (error, stackTrace) => mapSupabaseToFailure(authAction, error, stackTrace),
      );
}
