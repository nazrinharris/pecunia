// ignore_for_file: comment_references

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/util/pecunia_crypto.dart';
import 'package:pecunia/core/util/secret.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  Session._();

  factory Session.local({
    required String uid,
    required JWT jwt,
  }) = LocalSession;

  factory Session.remote({
    required String uid,
    required JWT jwt,
  }) = RemoteSession;

  factory Session.emptyLocal() => Session.local(uid: '', jwt: JWT(''));

  factory Session.emptyRemote() => Session.remote(uid: '', jwt: JWT(''));

  factory Session.fromLocalToken(String jwtString) {
    final jwt = JWT.decode(jwtString);
    final uid = (jwt.payload as Map<String, dynamic>)['uid'] as String;

    return Session.local(uid: uid, jwt: JWT.decode(jwtString));
  }

  /// This is what is stored in [kPecuniaUserTokenKey]. It is a JWT.
  ///
  /// You can also use [Session.key] to get the key to store this accessToken in [FlutterSecureStorage].
  ///
  /// Use [Session.fromLocalToken] to decode.
  String get accessToken => when(
        local: (uid, jwt) => jwt.sign(SecretKey(PecuniaSecrets.localJWTKey)),
        remote: (uid, jwt) => jwt.sign(SecretKey(PecuniaSecrets.localJWTKey)),
      );

  /// `key` is used to store the session in the [FlutterSecureStorage].
  String get key => when(
        local: (uid, jwt) => kPecuniaUserTokenKey(uid),
        remote: (uid, jwt) => kPecuniaUserTokenKey(uid),
      );

  static JWT createLocalToken(PecuniaUser user) {
    return JWT({
      'uid': user.uid,
      'username': user.username,
      'email': user.email,
      'dateCreated': user.dateCreated.toIso8601String(),
      'userType': user.userType.typeAsString,
    });
  }

  TaskEither<AuthFailure, PecuniaUser> getUser() => TaskEither.tryCatch(
        () async {
          final payload = jwt.payload as Map<String, dynamic>;
          final userType = UserType.fromString(payload['userType'] as String? ?? 'unknown');

          return PecuniaUser(
            uid: payload['uid'] as String,
            username: payload['username'] as String,
            email: payload['email'] as String?,
            dateCreated: DateTime.parse(payload['dateCreated'] as String),
            userType: userType,
          );
        },
        (error, stackTrace) => AuthFailure.unknown(
          message: 'Something went wrong while retrieving user from session',
          stackTrace: stackTrace,
          rawException: error,
        ),
      );

  static String sessionStorageKey(String uid) => 'pecunia_user_token_$uid';

  @override
  String toString() {
    return 'Session(uid: $uid, jwt_payload: ${jwt.payload})';
  }
}
