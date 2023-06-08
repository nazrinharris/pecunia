import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_exceptions.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_failures.dart';
import 'package:pecunia/core/network_info/network_info.dart';
import 'package:pecunia/core/third_party_providers.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/models/session.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

final authRemoteDSProvider = Provider<AuthRemoteDS>(
  (ref) => SupabaseAuthRemoteDS(
    ref.watch(supabaseProvider),
    ref.watch(networkInfoProvider),
  ),
);

typedef PecuniaUserDTOAndSession = ({PecuniaUserDTO pecuniaUserDTO, Session newSession});
typedef SupaUserAndSession = ({s.User user, Session newSession});
typedef AuthResponseAndSession = ({s.AuthResponse response, Session currentSession});

abstract interface class AuthRemoteDS {
  TaskEither<Failure, PecuniaUserDTOAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<Failure, PecuniaUserDTOAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  });

  TaskEither<Failure, Session> logout(Session currentSession);
}

class SupabaseAuthRemoteDS implements AuthRemoteDS {
  SupabaseAuthRemoteDS(this.supabaseClient, this.network);

  final s.SupabaseClient supabaseClient;
  final NetworkInfo network;

  @override
  TaskEither<Failure, PecuniaUserDTOAndSession> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return network
        .isConnected()
        .flatMap<AuthResponseAndSession>(
          (isConnected) => isConnected
              ? _requestLoginWithPassword(email: email, password: password, currentSession: currentSession)
              : TaskEither.left(NoInternetFailure(stackTrace: StackTrace.current)),
        )
        .flatMap((r) => _getUserFromResponse(r.response, r.currentSession))
        .flatMap((r) => _mapToDTO(r.user, r.newSession));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> _requestLoginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) =>
      TaskEither.tryCatch(
        () async {
          final response = await supabaseClient.auth.signInWithPassword(
            email: email,
            password: password,
          );
          return (response: response, currentSession: const Session(isValid: true));
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  TaskEither<AuthFailure, SupaUserAndSession> _getUserFromResponse(
    s.AuthResponse response,
    Session newSession,
  ) =>
      TaskEither.tryCatch(
        () async {
          final user = response.user;

          if (user == null || user.appMetadata['username'] == null) {
            throw MissingUsernameException(stackTrace: StackTrace.current);
          }
          return (user: user, newSession: newSession);
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  TaskEither<AuthFailure, PecuniaUserDTOAndSession> _mapToDTO(s.User user, Session newSession) =>
      TaskEither.tryCatch(
        () async {
          return (
            pecuniaUserDTO: PecuniaUserDTO(
              uid: user.id,
              username: user.appMetadata['username'] as String,
              dateCreated: DateTime.parse(user.createdAt),
            ),
            newSession: newSession
          );
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  @override
  TaskEither<Failure, PecuniaUserDTOAndSession> registerWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return network
        .isConnected()
        .flatMap<AuthResponseAndSession>(
          (isConnected) => isConnected
              ? _requestRegisterWithPassword(
                  username: username,
                  email: email,
                  password: password,
                  currentSession: currentSession,
                )
              : TaskEither.left(NoInternetFailure(stackTrace: StackTrace.current)),
        )
        .flatMap((r) => _getUserFromResponse(r.response, r.currentSession))
        .flatMap((r) => _mapToDTO(r.user, r.newSession));
  }

  TaskEither<AuthFailure, AuthResponseAndSession> _requestRegisterWithPassword({
    required String username,
    required String email,
    required String password,
    required Session currentSession,
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
        return mapSupabaseToFailure(AuthAction.register, error, stackTrace);
      },
    );
  }

  @override
  TaskEither<Failure, Session> logout(Session currentSession) {
    return network.isConnected().flatMap(
          (isConnected) => isConnected
              ? _requestLogout(currentSession)
              : TaskEither.left(NoInternetFailure(stackTrace: StackTrace.current)),
        );
  }

  TaskEither<Failure, Session> _requestLogout(Session currentSession) {
    return TaskEither.tryCatch(
      () async {
        await supabaseClient.auth.signOut();
        return currentSession.copyWith(isValid: false);
      },
      (error, stackTrace) => mapSupabaseToFailure(AuthAction.logout, error, stackTrace),
    );
  }
}
