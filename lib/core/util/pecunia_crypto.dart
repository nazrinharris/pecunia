import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_crypto.g.dart';

/// [kPecuniaUserKey] is the key for the user's data, stored with `PecuniaUser.toJson()`. An example of the key is `pecunia_user_1234567890`.
String kPecuniaUserKey(String uid) => 'pecunia_user_$uid';

/// [kPecuniaUserHashedPasswordKey] is the key for the user's hashed password, stored with `PecuniaCrypto.hashPassword()`. An example of the key is `pecunia_user_hashed_password_1234567890`.
String kPecuniaUserHashedPasswordKey(String uid) => 'pecunia_user_hashed_password_$uid';

/// [kPecuniaUserSaltKey] is the key for the user's salt, stored with `PecuniaCrypto.generateSalt()`. An example of the key is `pecunia_user_salt_1234567890`.
String kPecuniaUserSaltKey(String uid) => 'pecunia_user_salt_$uid';

/// [kPecuniaUserUidKey] is the key for the user's uid, stored with `PecuniaUser.uid`. An example of the key is `pecunia_user_uid_myepicemail@mail.com`.
String kPecuniaUserUidKey(String email) => 'pecunia_user_uid_$email';

/// [kPecuniaUserTokenKey] is the key for the user's token, stored with `Session.accessToken`. An example of the key is `pecunia_user_token_1234567890`.
String kPecuniaUserTokenKey(String uid) => 'pecunia_user_token_$uid';

@Riverpod(keepAlive: true)
PecuniaCrypto pecuniaCrypto(PecuniaCryptoRef ref) {
  return PecuniaCrypto();
}

class PecuniaCrypto {
  String generateSalt() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  String hashPassword({
    required String password,
    required String salt,
  }) {
    final bytes = utf8.encode(salt + password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
