// ignore_for_file: comment_references

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  factory Session.fromLocalToken(String uid, String jwtString) {
    return Session.local(uid: uid, jwt: JWT.decode(jwtString));
  }

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
    });
  }

  PecuniaUser getUser() {
    final payload = jwt.payload as Map<String, dynamic>;
    return PecuniaUser(
      uid: payload['uid'] as String,
      username: payload['username'] as String,
      email: payload['email'] as String?,
      dateCreated: DateTime.parse(payload['dateCreated'] as String),
    );
  }

  static String sessionStorageKey(String uid) => 'pecunia_user_token_$uid';

  @override
  String toString() {
    return 'Session(uid: $uid, jwt_payload: ${jwt.payload})';
  }
}
