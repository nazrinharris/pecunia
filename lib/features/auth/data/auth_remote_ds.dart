import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_exceptions.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/network_info_errors/network_info_failures.dart';
import 'package:pecunia/core/network_info/network_info.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/models/session.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

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
              ? requestLoginWithPassword(email: email, password: password, currentSession: currentSession)
              : TaskEither.left(NoInternetFailure(stackTrace: StackTrace.current)),
        )
        .flatMap((r) => getUserFromResponse(r.response, r.currentSession))
        .flatMap((r) => mapToDTO(r.user, r.newSession));
  }

  TaskEither<Failure, AuthResponseAndSession> requestLoginWithPassword({
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

  TaskEither<Failure, SupaUserAndSession> getUserFromResponse(s.AuthResponse response, Session newSession) =>
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

  TaskEither<Failure, PecuniaUserDTOAndSession> mapToDTO(s.User user, Session newSession) =>
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
    // TODO(nazrinharris): implement registerWithPassword
    throw UnimplementedError();
  }
}
