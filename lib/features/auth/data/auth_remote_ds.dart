import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';
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
      AuthRemoteDSHelper(),
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
  SupabaseAuthRemoteDS(this.supabaseClient, this.network, this.helper);

  final s.SupabaseClient supabaseClient;
  final NetworkInfo network;
  final AuthRemoteDSHelper helper;

  /// ******************************************************************************************************
  /// * [loginWithPassword]
  /// ******************************************************************************************************
  @override
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    const currentAction = AuthAction.login;
    return network
        .isConnected()
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<AuthResponseAndSession>(_loginIfConnected(
          currentAction: currentAction,
          currentSession: currentSession,
          email: email,
          password: password,
        ))
        .flatMap((r) => helper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
              currentAction,
            ))
        .flatMap((r) => helper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
              currentAction,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> Function(bool isConnected) _loginIfConnected({
    required String email,
    required String password,
    required Session currentSession,
    required AuthAction currentAction,
  }) {
    return (isConnected) {
      return isConnected
          ? TaskEither.tryCatch(
              () async {
                final response = await supabaseClient.auth.signInWithPassword(
                  email: email,
                  password: password,
                );
                return (response: response, currentSession: const Session(isValid: true));
              },
              (error, stackTrace) => mapSupabaseToFailure(currentAction, error, stackTrace),
            )
          : TaskEither.left(AuthFailure.noInternet(
              authAction: currentAction,
              message: AuthErrorType.noInternet.message,
              stackTrace: StackTrace.current,
            ));
    };
  }

  /// ******************************************************************************************************
  /// * [registerWithPassword]
  /// ******************************************************************************************************
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
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<AuthResponseAndSession>(_registerIfConnected(
            currentAction: currentAction,
            currentSession: currentSession,
            username: username,
            email: email,
            password: password))
        .flatMap((r) => helper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
              currentAction,
            ))
        .flatMap((r) => helper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
              currentAction,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> Function(bool isConnected) _registerIfConnected({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
    required AuthAction currentAction,
  }) {
    return (isConnected) {
      return isConnected
          ? TaskEither.tryCatch(
              () async {
                final response = await supabaseClient.auth.signUp(
                  email: email,
                  password: password,
                  data: {'username': username},
                );
                return (response: response, currentSession: const Session(isValid: true));
              },
              (error, stackTrace) => mapSupabaseToFailure(currentAction, error, stackTrace),
            )
          : TaskEither.left(AuthFailure.noInternet(
              authAction: currentAction,
              message: AuthErrorType.noInternet.message,
              stackTrace: StackTrace.current,
            ));
    };
  }

  /// ******************************************************************************************************
  /// * [logout]
  /// ******************************************************************************************************
  @override
  TaskEither<AuthFailure, Session> logout(Session currentSession) {
    const currentAction = AuthAction.logout;
    return network
        .isConnected()
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<Session>(logoutIfConnected(currentSession: currentSession, currentAction: currentAction));
  }

  TaskEither<AuthFailure, Session> Function(bool isConnected) logoutIfConnected({
    required Session currentSession,
    required AuthAction currentAction,
  }) {
    return (isConnected) {
      return isConnected
          ? TaskEither.tryCatch(
              () async {
                await supabaseClient.auth.signOut();
                return currentSession.copyWith(isValid: false);
              },
              (error, stackTrace) => mapSupabaseToFailure(currentAction, error, stackTrace),
            )
          : TaskEither.left(AuthFailure.noInternet(
              authAction: currentAction,
              message: AuthErrorType.noInternet.message,
              stackTrace: StackTrace.current,
            ));
    };
  }

  /// ******************************************************************************************************
  /// * [getLoggedInUser]
  /// ******************************************************************************************************
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
    return helper.mapSupaUserToDTO(user, currentAction);
  }
}

/// ========================================================================================================
/// Also see [SupabaseAuthRemoteDS]
///
/// This class provides utility methods for handling common tasks
/// related to authentication in the context of the `SupabaseAuthRemoteDS` class.
///
/// It's primarily designed to keep the code in `SupabaseAuthRemoteDS` more clean
/// and readable by abstracting away some of the lower-level operations that
/// are needed for authentication.
/// ========================================================================================================
class AuthRemoteDSHelper {
  /// Tries to map a Supabase User object to a PecuniaUserDTO object,
  /// and wraps the operation in a TaskEither to handle potential errors.
  ///
  /// If the mapping is successful, it will return a Right with the DTO.
  /// If an error occurs, it will return a Left with an AuthFailure.
  TaskEither<AuthFailure, PecuniaUserDTO> mapSupaUserToDTO(
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

  /// Similar to `mapSupaUserToDTO`, but also includes the session information.
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> mapSupaUserToDTOWithSession(
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

  /// Tries to extract the user and update session information from a Supabase AuthResponse,
  /// and wraps the operation in a TaskEither to handle potential errors.
  ///
  /// If the extraction is successful, it will return a Right with the user and session.
  /// If an error occurs, it will return a Left with an AuthFailure.
  TaskEither<AuthFailure, SupaUserAndSession> getUserFromAuthResponse(
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

  /// Converts a `NetworkInfoFailure` to an `AuthFailure`.
  AuthFailure mapNetworkInfoFailureToAuthFailure(NetworkInfoFailure failure) {
    return AuthFailure.unknown(
        stackTrace: StackTrace.current,
        message: AuthErrorType.unknown.message,
        authAction: AuthAction.unknown);
  }
}
