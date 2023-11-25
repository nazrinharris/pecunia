import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/core/util/pecunia_crypto.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'auth_local_ds.g.dart';

@riverpod
AuthLocalDS authLocalDS(AuthLocalDSRef ref) => AuthLocalDS(
      prefs: ref.watch(pecuniaSharedPreferencesProvider).requireValue,
      pecuniaCrypto: ref.watch(pecuniaCryptoProvider),
      uuid: ref.watch(uuidProvider),
      sessionManager: AuthLocalSessionManager(ref.watch(pecuniaFlutterSecureStorageProvider).requireValue),
      secureStorage: AuthSecuredStorageManager(ref.watch(pecuniaFlutterSecureStorageProvider).requireValue),
    );

class AuthLocalDS {
  AuthLocalDS({
    required this.prefs,
    required this.uuid,
    required this.sessionManager,
    required this.secureStorage,
    required this.pecuniaCrypto,
  });

  final SharedPreferences prefs;
  final PecuniaCrypto pecuniaCrypto;
  final AuthLocalSessionManager sessionManager;
  final AuthSecuredStorageManager secureStorage;
  final Uuid uuid;

  /// `storeSavedUser` method is used to record in [kPrefsSavedUsers] that a user has once logged in
  /// or registered, and their data is still on the app. If the user logs out, their
  /// record should persist, unless they choose to clear their data.
  ///
  /// The aim for this record is to be able to know how many users have logged in to the app, and still has their
  /// app data in the `pecunia_db_<uid>.db` file.
  ///
  /// The structure of the stored data is of type JSON, and is as follows:
  /// ```json
  /// <kPrefsSavedUsers> : {
  ///  "uid": "username",
  /// }
  ///```
  ///
  /// Counter: Since there's a list of local users, (recorded in [kPecuniaUserUidKey] and by extension [kPecuniaUserKey]),
  /// would this record even be necessary? We can just check if the user's uid is in the list of local users.
  ///
  /// Counter to counter: What about remote users? [kPrefsSavedUsers] serve to be the list of BOTH local and remote users.
  TaskEither<AuthFailure, Unit> storeSavedUser(PecuniaUser user) {
    return TaskEither.tryCatch(
      () async {
        final allUsersString = prefs.getString(kPrefsSavedUsers) ?? '{}';
        final allUsers = jsonDecode(allUsersString) as Map<String, dynamic>;
        allUsers[user.uid] = user.username;
        await prefs.setString(kPrefsSavedUsers, jsonEncode(allUsers));

        return unit;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.cannotStoreSavedUser.message,
        errorType: AuthErrorType.cannotStoreSavedUser,
        rawException: e,
      ),
    );
  }

  /// `removeSavedUser` method is used to remove a user's record from the app.
  /// This doesn't take responsibility of actually removing the database linked to the user, it simply
  /// removes the user from the [kPrefsSavedUsers] list.
  ///
  /// Also see [AuthLocalDS.storeSavedUser]
  TaskEither<AuthFailure, Unit> removeSavedUser(String uid) {
    return TaskEither.tryCatch(
      () async {
        final allUsersString = prefs.getString(kPrefsSavedUsers) ?? '{}';
        final allUsers = jsonDecode(allUsersString) as Map<String, dynamic>..remove(uid);
        await prefs.setString(kPrefsSavedUsers, jsonEncode(allUsers));

        return unit;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.cannotRemoveSavedUser.message,
        errorType: AuthErrorType.cannotRemoveSavedUser,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, Map<String, dynamic>> getAllSavedUsers() {
    return TaskEither.tryCatch(
      () async {
        final allUsersString = prefs.getString(kPrefsSavedUsers) ?? '{}';
        final allUsers = jsonDecode(allUsersString) as Map<String, dynamic>;

        return allUsers;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.cannotGetAllSavedUsers.message,
        errorType: AuthErrorType.cannotGetAllSavedUsers,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, PecuniaUserAndSession> registerWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) {
    return TaskEither<AuthFailure, ({PecuniaUser user, String hashedPassword, String salt})>.tryCatch(
      () async {
        final salt = pecuniaCrypto.generateSalt();
        final hashedPassword = pecuniaCrypto.hashPassword(password: password, salt: salt);
        final user = PecuniaUser(
          uid: uuid.v4(),
          username: username,
          email: email,
          dateCreated: DateTime.now(),
        );

        return (user: user, hashedPassword: hashedPassword, salt: salt);
      },
      (e, s) => AuthFailure.unknown(stackTrace: s, message: 'Uh oh'),
    ).flatMap(secureStorage.storeUserCredentials).flatMap(sessionManager.createSession);
  }

  TaskEither<AuthFailure, PecuniaUserAndSession> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return secureStorage
        .getUserCredentials(email)
        .flatMap<String>((r) {
          final hashedPassword = pecuniaCrypto.hashPassword(password: password, salt: r.salt);
          if (hashedPassword != r.hashedPassword) {
            return TaskEither.left(AuthFailure.incorrectCredentials(
              stackTrace: StackTrace.current,
              message: 'Incorrect password.',
            ));
          }
          return TaskEither.right(r.uid);
        })
        .flatMap(secureStorage.getUserData)
        .flatMap(sessionManager.createSession);
  }

  TaskEither<AuthFailure, Unit> logout(String uid) {
    return sessionManager.getSession(uid).flatMap((r) => sessionManager.removeSession(r.uid));
  }

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    return sessionManager.getAllSessions().flatMap((sessions) {
      // As of now, we only support one session at a time.
      if (sessions.length > 1) {
        return TaskEither.left(AuthFailure.unknown(
          stackTrace: StackTrace.current,
          message: 'More than one session found.',
        ));
      }

      if (sessions.isEmpty) {
        return TaskEither.right(none());
      }

      final session = sessions.first;

      return TaskEither.right(some(session.getUser()));
    });
  }
}

/// `AuthLocalSessionManager` is a helper class which manages the storing of the session in the device through
/// the [FlutterSecureStorage] plugin.
class AuthLocalSessionManager {
  AuthLocalSessionManager(this.flutterSecureStorage);

  final FlutterSecureStorage flutterSecureStorage;

  /// Creates a new session for the given user.
  ///
  /// This method first removes any existing session for the user, then creates a new one.
  /// The session is stored in the secure storage with the user's uid as the key.
  ///
  /// Returns a [TaskEither] that will either contain an [AuthFailure] if something went wrong,
  /// or a record containing the [PecuniaUser] and the created [Session].
  TaskEither<AuthFailure, ({PecuniaUser user, Session session})> createSession(PecuniaUser user) {
    return removeSession(user.uid).flatMap(
      (r) => TaskEither.tryCatch(
        () async {
          final session = Session.remote(uid: user.uid, jwt: Session.createLocalToken(user));
          await flutterSecureStorage.write(key: session.key, value: session.accessToken);
          return (user: user, session: session);
        },
        (e, s) => AuthFailure(
          stackTrace: s,
          message: AuthErrorType.localFailedStoreSession.message,
          errorType: AuthErrorType.localFailedStoreSession,
          rawException: e,
        ),
      ),
    );
  }

  TaskEither<AuthFailure, Session> getSession(String uid) {
    return TaskEither.tryCatch(
      () async => flutterSecureStorage.read(key: Session.sessionStorageKey(uid)),
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedGetSession.message,
        errorType: AuthErrorType.localFailedGetSession,
        rawException: e,
      ),
    ).flatMap((token) {
      if (token == null) {
        return TaskEither.left(AuthFailure.unknown(
          stackTrace: StackTrace.current,
          message: 'No session found for user with uid $uid.',
        ));
      }

      return TaskEither.right(Session.fromLocalToken(uid, token));
    });
  }

  TaskEither<AuthFailure, Unit> removeSession(String uid) {
    return TaskEither.tryCatch(
      () async {
        await flutterSecureStorage.delete(key: kPecuniaUserTokenKey(uid));
        return unit;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedRemoveSession.message,
        errorType: AuthErrorType.localFailedRemoveSession,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, List<Session>> getAllSessions() {
    return TaskEither.tryCatch(
      () async {
        final allSessions = await flutterSecureStorage.readAll();
        final sessionKeys = allSessions.keys.where((key) => key.contains('pecunia_user_token_'));
        final sessions = sessionKeys.map((key) => Session.fromLocalToken(key, allSessions[key]!)).toList();

        return sessions;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedGetSession.message,
        errorType: AuthErrorType.localFailedGetSession,
        rawException: e,
      ),
    );
  }
}

/// `AuthSecuredStorageManager` is a helper class which manages the storing of the user's data in the device through
/// the [FlutterSecureStorage] plugin.
///
/// This class is used to store the user's credentials.
class AuthSecuredStorageManager {
  AuthSecuredStorageManager(this.flutterSecureStorage);

  final FlutterSecureStorage flutterSecureStorage;

  TaskEither<AuthFailure, PecuniaUser> storeUserCredentials(
    ({
      String hashedPassword,
      String salt,
      PecuniaUser user,
    }) args,
  ) {
    return TaskEither.tryCatch(
      () async {
        await flutterSecureStorage.write(
            key: kPecuniaUserKey(args.user.uid), value: jsonEncode(args.user.toJson()));
        await flutterSecureStorage.write(
            key: kPecuniaUserHashedPasswordKey(args.user.uid), value: args.hashedPassword);
        await flutterSecureStorage.write(key: kPecuniaUserSaltKey(args.user.uid), value: args.salt);
        await flutterSecureStorage.write(key: kPecuniaUserUidKey(args.user.email!), value: args.user.uid);

        return args.user;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.failedStoreUserCredentials.message,
        errorType: AuthErrorType.failedStoreUserCredentials,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, PecuniaUser> getUserData(String uid) {
    return TaskEither.tryCatch(
      () async {
        final userDataString = await flutterSecureStorage.read(key: kPecuniaUserKey(uid));
        final userData = jsonDecode(userDataString!) as Map<String, dynamic>;

        return PecuniaUser.fromJson(userData);
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedGetUserData.message,
        errorType: AuthErrorType.localFailedGetUserData,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, PecuniaUser> deleteUserDataAndCredentials(String email) {
    return TaskEither.tryCatch(
      () async {
        final uid = await flutterSecureStorage.read(key: kPecuniaUserUidKey(email));

        await flutterSecureStorage.delete(key: kPecuniaUserKey(uid!));
        await flutterSecureStorage.delete(key: kPecuniaUserHashedPasswordKey(uid));
        await flutterSecureStorage.delete(key: kPecuniaUserSaltKey(uid));
        await flutterSecureStorage.delete(key: kPecuniaUserUidKey(uid));

        return PecuniaUser.empty();
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedDeleteUserDataAndCredentials.message,
        errorType: AuthErrorType.localFailedDeleteUserDataAndCredentials,
        rawException: e,
      ),
    );
  }

  /// Retrieves the user credentials (uid, hashedPassword, salt) associated with the given email address.
  ///
  /// This method first obtains the user ID based on the email and then fetches
  /// the user's credentials (hashed password and salt) associated with that ID.
  ///
  /// [email] The email address of the user whose credentials are being retrieved.
  ///
  /// Returns a [TaskEither] that holds either [AuthFailure] on failure or
  /// a map containing user's UID, hashed password, and salt on success.
  ///
  /// 1. Returns [AuthFailure] of type [AuthErrorType.incorrectCredentials] if no user is found with the given email
  /// 2. Returns [AuthFailure] of type [AuthErrorType.localMissingHashedPasswordOrSalt] if a user is found but no hashed password or salt is found.
  /// 3. Returns [AuthFailure] of type [AuthErrorType.localFailedGetUserCredentials] if something else went wrong.
  TaskEither<AuthFailure, ({String uid, String hashedPassword, String salt})> getUserCredentials(
    String email,
  ) {
    return TaskEither.tryCatch(
      () async => flutterSecureStorage.read(key: kPecuniaUserUidKey(email)),
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.localFailedGetUserCredentials.message,
        errorType: AuthErrorType.localFailedGetUserCredentials,
        rawException: e,
      ),
    ).flatMap<String>((r) {
      if (r == null) {
        return TaskEither.left(AuthFailure.incorrectCredentials(
          stackTrace: StackTrace.current,
          message: 'No user found with email $email.',
        ));
      } else {
        return TaskEither.right(r);
      }
    }).flatMap(
      (uid) => TaskEither.tryCatch(
        () async {
          final hashedPassword = await flutterSecureStorage.read(key: kPecuniaUserHashedPasswordKey(uid));
          final salt = await flutterSecureStorage.read(key: kPecuniaUserSaltKey(uid));

          return (uid: uid, hashedPassword: hashedPassword, salt: salt);
        },
        (e, s) => AuthFailure(
          stackTrace: s,
          message: AuthErrorType.localFailedGetUserCredentials.message,
          errorType: AuthErrorType.localFailedGetUserCredentials,
          rawException: e,
        ),
      ).flatMap((r) {
        if (r.hashedPassword == null || r.salt == null) {
          return TaskEither.left(AuthFailure(
            stackTrace: StackTrace.current,
            errorType: AuthErrorType.localMissingHashedPasswordOrSalt,
            message: 'User with uid $uid was found but no hashed password or salt was found.',
          ));
        }
        return TaskEither.right((uid: r.uid, hashedPassword: r.hashedPassword!, salt: r.salt!));
      }),
    );
  }
}
