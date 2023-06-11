import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_exceptions.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_failures.dart';
import 'package:pecunia/core/network_info/network_info.dart';
import 'package:pecunia/core/providers/supabase/supabase_provider.dart';
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

  TaskEither<Failure, PecuniaUserDTO> getLoggedInUser();

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
        .flatMap((r) => SupabaseAuthRemoteDSHelper.getUserFromAuthResponse(r.response, r.currentSession))
        .flatMap((r) => SupabaseAuthRemoteDSHelper.mapSupaUserToDTOWithSession(r.user, r.newSession));
  }

  TaskEither<Failure, AuthResponseAndSession> _requestLoginWithPassword({
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
        .flatMap((r) => SupabaseAuthRemoteDSHelper.getUserFromAuthResponse(r.response, r.currentSession))
        .flatMap((r) => SupabaseAuthRemoteDSHelper.mapSupaUserToDTOWithSession(r.user, r.newSession));
  }

  TaskEither<Failure, AuthResponseAndSession> _requestRegisterWithPassword({
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

  @override
  TaskEither<Failure, PecuniaUserDTO> getLoggedInUser() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      return TaskEither.left(NoLoggedInUserFailure(
        message: 'No user is currently logged in',
        stackTrace: StackTrace.current,
      ));
    }
    return SupabaseAuthRemoteDSHelper.mapSupaUserToDTO(user);
  }
}

class SupabaseAuthRemoteDSHelper {
  static TaskEither<Failure, PecuniaUserDTO> mapSupaUserToDTO(s.User user) => TaskEither.tryCatch(
        () async {
          return PecuniaUserDTO(
            uid: user.id,
            email: user.email,
            username: user.userMetadata!['username'] as String,
            dateCreated: DateTime.parse(user.createdAt),
          );
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  static TaskEither<Failure, PecuniaUserDTOAndSession> mapSupaUserToDTOWithSession(
          s.User user, Session newSession) =>
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
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  static TaskEither<Failure, SupaUserAndSession> getUserFromAuthResponse(
    s.AuthResponse response,
    Session newSession,
  ) =>
      TaskEither.tryCatch(
        () async {
          final user = response.user;

          if (user == null || user.userMetadata?['username'] == null) {
            throw MissingUsernameException(stackTrace: StackTrace.current);
          }
          return (user: user, newSession: newSession);
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );
}
