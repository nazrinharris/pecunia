import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_exceptions.dart';
import 'package:pecunia/core/network_info/network_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '../../../core/errors/auth_errors/auth_failures.dart';
import '../../../core/errors/failures.dart';
import '../../../core/errors/network_info_errors/network_info_failures.dart';
import '../domain/auth_repo.dart';
import '../domain/models/pecunia_user.dart';
import '../domain/models/session.dart';

abstract interface class AuthRemoteDS {
  TaskEither<Failure, ({PecuniaUserDTO pecuniaUserDTO, Session newSession})> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  });
}

class SupabaseAuthRemoteDS implements AuthRemoteDS {
  final s.SupabaseClient supabaseClient;
  final NetworkInfo network;

  SupabaseAuthRemoteDS(this.supabaseClient, this.network);

  @override
  TaskEither<Failure, ({PecuniaUserDTO pecuniaUserDTO, Session newSession})> loginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) {
    return network
        .isConnected()
        .flatMap((isConnected) {
          if (!isConnected) {
            return TaskEither.left(NoInternetFailure(stackTrace: StackTrace.current));
          }
          return TaskEither.right(isConnected);
        })
        .flatMap(
            (_) => requestLoginWithPassword(email: email, password: password, currentSession: currentSession))
        .flatMap((r) => getUserFromResponse(r.response, r.session))
        .flatMap((r) => mapToDTO(r.user, r.newSession));
  }

  TaskEither<Failure, ({s.AuthResponse response, Session session})> requestLoginWithPassword({
    required String email,
    required String password,
    required Session currentSession,
  }) =>
      TaskEither.tryCatch(
        () async {
          final s.AuthResponse response = await supabaseClient.auth.signInWithPassword(
            email: email,
            password: password,
          );
          return (response: response, session: Session(isValid: true));
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  TaskEither<Failure, ({s.User user, Session newSession})> getUserFromResponse(
          s.AuthResponse response, Session newSession) =>
      TaskEither.tryCatch(
        () async {
          final s.User? user = response.user;

          if (user == null || user.appMetadata["username"] == null) {
            throw MissingUsernameException(stackTrace: StackTrace.current);
          }
          return (user: user, newSession: newSession);
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );

  TaskEither<Failure, ({PecuniaUserDTO pecuniaUserDTO, Session newSession})> mapToDTO(
          s.User user, Session newSession) =>
      TaskEither.tryCatch(
        () async {
          return (
            pecuniaUserDTO: PecuniaUserDTO(
              uid: user.id,
              username: user.appMetadata["username"],
              dateCreated: DateTime.parse(user.createdAt),
            ),
            newSession: newSession
          );
        },
        (error, stackTrace) => mapSupabaseToFailure(AuthAction.login, error, stackTrace),
      );
}
