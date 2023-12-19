import 'dart:convert';
import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_crypto.g.dart';

/// [kPecuniaUserKey] is the key for the user's data, stored with `PecuniaUser.toJson()`. An example of the key is `pecunia_user_1234567890`.
String kPecuniaUserKey(String uid) => 'pecunia_user_$uid';

/// [kPecuniaUserHashedPasswordKey] is the key for the user's hashed password, stored with `PecuniaCrypto.hashPassword()`. An example of the key is `pecunia_user_hashed_password_1234567890`.
String kPecuniaUserHashedPasswordKey(String uid) => 'pecunia_user_hashed_password_$uid';

/// [kPecuniaUserUidKey] is the key for the user's uid, stored with `PecuniaUser.uid`. An example of the key is `pecunia_user_uid_myepicemail@mail.com`.
String kPecuniaUserUidKey(String email) => 'pecunia_user_uid_$email';

/// [kPecuniaUserTokenKey] is the key for the user's token, stored with `Session.accessToken`. An example of the key is `pecunia_user_token_1234567890`.
String kPecuniaUserTokenKey(String uid) => 'pecunia_user_token_$uid';

/// [kPecuniaActiveLocalSessionKey] is the key for the user's active local session, stored with `Session.key`.
const String kPecuniaActiveLocalSessionKey = 'pecunia_active_local_session';

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

  String hashPasswordBCrypt({
    required String password,
  }) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool verifyPassword({
    required String password,
    required String hashedPassword,
  }) {
    // Attempt BCrypt hash comparison
    return BCrypt.checkpw(password, hashedPassword);
  }
}
