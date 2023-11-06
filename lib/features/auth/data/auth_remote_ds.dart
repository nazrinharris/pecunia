import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_errors.dart';
import 'package:pecunia/core/infrastructure/network_info/network_info.dart';
import 'package:pecunia/core/infrastructure/supabase/pecunia_supabase.dart';
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

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser();

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
    return network
        .isConnected()
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<AuthResponseAndSession>(_loginIfConnected(
          currentSession: currentSession,
          email: email,
          password: password,
        ))
        .flatMap((r) => helper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
            ))
        .flatMap((r) => helper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> Function(bool isConnected) _loginIfConnected({
    required String email,
    required String password,
    required Session currentSession,
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
              mapSupabaseToFailure,
            )
          : TaskEither.left(AuthFailure.noInternet(
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
    return network
        .isConnected()
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<AuthResponseAndSession>(_registerIfConnected(
            currentSession: currentSession, username: username, email: email, password: password))
        .flatMap((r) => helper.getUserFromAuthResponse(
              r.response,
              r.currentSession,
            ))
        .flatMap((r) => helper.mapSupaUserToDTOWithSession(
              r.user,
              r.newSession,
            ));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> Function(bool isConnected) _registerIfConnected({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
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
              mapSupabaseToFailure,
            )
          : TaskEither.left(AuthFailure.noInternet(
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
    return network
        .isConnected()
        .mapLeft(helper.mapNetworkInfoFailureToAuthFailure)
        .flatMap<Session>(logoutIfConnected(currentSession: currentSession));
  }

  TaskEither<AuthFailure, Session> Function(bool isConnected) logoutIfConnected({
    required Session currentSession,
  }) {
    return (isConnected) {
      return isConnected
          ? TaskEither.tryCatch(
              () async {
                await supabaseClient.auth.signOut();
                return currentSession.copyWith(isValid: false);
              },
              mapSupabaseToFailure,
            )
          : TaskEither.left(AuthFailure.noInternet(
              message: AuthErrorType.noInternet.message,
              stackTrace: StackTrace.current,
            ));
    };
  }

  /// ******************************************************************************************************
  /// * [getLoggedInUser]
  /// ******************************************************************************************************
  @override
  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      return TaskEither.of(const Option<PecuniaUser>.none());
    }
    return helper.mapSupaUserToDTO(user).flatMap((r) => TaskEither.of(Option.of(PecuniaUser.fromDTO(r))));
  }
}

/// ******************************************************************************************************
/// Also see [SupabaseAuthRemoteDS]
///
/// This class provides utility methods for handling common tasks
/// related to authentication in the context of the `SupabaseAuthRemoteDS` class.
///
/// It's primarily designed to keep the code in `SupabaseAuthRemoteDS` more clean
/// and readable by abstracting away some of the lower-level operations that
/// are needed for authentication.
/// ******************************************************************************************************
class AuthRemoteDSHelper {
  /// Tries to map a Supabase User object to a PecuniaUserDTO object,
  /// and wraps the operation in a TaskEither to handle potential errors.
  ///
  /// If the mapping is successful, it will return a Right with the DTO.
  /// If an error occurs, it will return a Left with an AuthFailure.
  TaskEither<AuthFailure, PecuniaUserDTO> mapSupaUserToDTO(
    s.User user,
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
        mapSupabaseToFailure,
      );

  /// Similar to `mapSupaUserToDTO`, but also includes the session information.
  TaskEither<AuthFailure, PecuniaUserDTOAndSession> mapSupaUserToDTOWithSession(
    s.User user,
    Session newSession,
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
        mapSupabaseToFailure,
      );

  /// Tries to extract the user and update session information from a Supabase AuthResponse,
  /// and wraps the operation in a TaskEither to handle potential errors.
  ///
  /// If the extraction is successful, it will return a Right with the user and session.
  /// If an error occurs, it will return a Left with an AuthFailure.
  TaskEither<AuthFailure, SupaUserAndSession> getUserFromAuthResponse(
    s.AuthResponse response,
    Session newSession,
  ) =>
      TaskEither.tryCatch(
        () async {
          final user = response.user;

          if (user == null || user.userMetadata?['username'] == null) {
            throw AuthException(
              errorType: AuthErrorType.missingUsername,
              stackTrace: StackTrace.current,
            );
          }
          return (user: user, newSession: newSession);
        },
        mapSupabaseToFailure,
      );

  /// Converts a `NetworkInfoFailure` to an `AuthFailure`.
  AuthFailure mapNetworkInfoFailureToAuthFailure(NetworkInfoFailure failure) {
    return AuthFailure.unknown(
      stackTrace: StackTrace.current,
      message: AuthErrorType.unknown.message,
    );
  }
}
