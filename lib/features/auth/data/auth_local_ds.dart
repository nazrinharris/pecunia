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
  ///  "uid": <PecuniaUser.toJson()>,
  /// }
  ///```
  ///
  ///[kPrefsSavedUsers] serve to be the list of BOTH local and remote users.
  TaskEither<AuthFailure, Unit> storeSavedUser(PecuniaUser user) {
    return TaskEither.tryCatch(
      () async {
        final allUsersString = prefs.getString(kPrefsSavedUsers) ?? '{}';
        final allUsers = jsonDecode(allUsersString) as Map<String, dynamic>;
        allUsers[user.uid] = user.toJson();
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

  TaskEither<AuthFailure, List<PecuniaUser>> getAllSavedUsers() {
    return TaskEither.tryCatch(
      () async {
        final allUsersString = prefs.getString(kPrefsSavedUsers) ?? '{}';
        final allUsersMap = jsonDecode(allUsersString) as Map<String, dynamic>;
        final allUsers = allUsersMap.keys.map((key) {
          try {
            return PecuniaUser.fromJson(allUsersMap[key] as Map<String, dynamic>);
          } catch (e) {
            return PecuniaUser(
              uid: key,
              username: allUsersMap[key] as String,
              dateCreated: DateTime.now(),
            );
          }
        }).toList();

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
    return TaskEither<AuthFailure, ({PecuniaUser user, String hashedPassword})>.tryCatch(
      () async {
        final hashedPassword = pecuniaCrypto.hashPasswordBCrypt(password: password);
        final user = PecuniaUser(
          uid: uuid.v4(),
          username: username,
          email: email,
          dateCreated: DateTime.now(),
        );

        return (user: user, hashedPassword: hashedPassword);
      },
      (e, s) => AuthFailure.unknown(stackTrace: s, message: 'Uh oh'),
    )
        .flatMap(secureStorage.storeUserCredentials)
        .flatMap(sessionManager.createSession)
        .flatMap((r) => sessionManager.setAsLocalActiveSession(r.session).map((_) => r));
  }

  TaskEither<AuthFailure, PecuniaUserAndSession> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return secureStorage
        .getUserCredentials(email)
        .flatMap<String>((r) {
          final isCorrectPass = pecuniaCrypto.verifyPassword(
            password: password,
            hashedPassword: r.hashedPassword,
            salt: r.salt,
          );
          if (!isCorrectPass) {
            return TaskEither.left(AuthFailure.incorrectCredentials(
              stackTrace: StackTrace.current,
              message: 'Incorrect password.',
            ));
          }
          return TaskEither.right(r.uid);
        })
        .flatMap(secureStorage.getUserData)
        .flatMap(sessionManager.createSession)
        .flatMap((r) => sessionManager.setAsLocalActiveSession(r.session).map((_) => r));
  }

  /// Logs the user out, returns [Option.some(PecuniaUser)] if log out was successful, i.e there was an existing session to log out from. Returns [Option.none()] if no session was found.
  TaskEither<AuthFailure, Option<PecuniaUser>> logout() {
    return sessionManager.getActiveSession().flatMap((r) => r.fold(
          () => TaskEither.right(none()),
          (session) => sessionManager
              .removeSession(session.uid)
              .flatMap((_) => sessionManager.removeActiveSession())
              .map((_) => some(session.getUser())),
        ));
  }

  TaskEither<AuthFailure, Option<PecuniaUser>> getLoggedInUser() {
    return sessionManager.getActiveSession().flatMap((r) => r.fold(
          () => TaskEither.right(none()),
          (t) => TaskEither.right(some(t.getUser())),
        ));
  }
}

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
          final session = Session.local(uid: user.uid, jwt: Session.createLocalToken(user));
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

  TaskEither<AuthFailure, Unit> setAsLocalActiveSession(Session session) => TaskEither.tryCatch(
        () async {
          await flutterSecureStorage.write(
            key: kPecuniaActiveLocalSessionKey,
            value: session.accessToken,
          );
          return unit;
        },
        (e, s) => AuthFailure(
          stackTrace: s,
          message: AuthErrorType.localFailedSetLocalActiveSession.message,
          errorType: AuthErrorType.localFailedSetLocalActiveSession,
          rawException: e,
        ),
      );

  TaskEither<AuthFailure, Option<Session>> getActiveSession() => TaskEither.tryCatch(
        () async {
          final activeSession = await flutterSecureStorage.read(key: kPecuniaActiveLocalSessionKey);
          if (activeSession == null) {
            return none();
          }
          return Option.of(Session.fromLocalToken(activeSession));
        },
        (e, s) => AuthFailure(
          stackTrace: s,
          message: AuthErrorType.localFailedGetLocalActiveSession.message,
          errorType: AuthErrorType.localFailedGetLocalActiveSession,
          rawException: e,
        ),
      );

  TaskEither<AuthFailure, Unit> removeActiveSession() => TaskEither.tryCatch(
        () async {
          await flutterSecureStorage.delete(key: kPecuniaActiveLocalSessionKey);
          return unit;
        },
        (e, s) => AuthFailure(
          stackTrace: s,
          message: AuthErrorType.localFailedRemoveLocalActiveSession.message,
          errorType: AuthErrorType.localFailedRemoveLocalActiveSession,
          rawException: e,
        ),
      );

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

      return TaskEither.right(Session.fromLocalToken(token));
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
        final sessions = sessionKeys.map((key) => Session.fromLocalToken(allSessions[key]!)).toList();

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

class AuthSecuredStorageManager {
  AuthSecuredStorageManager(this.flutterSecureStorage);

  final FlutterSecureStorage flutterSecureStorage;

  TaskEither<AuthFailure, PecuniaUser> storeUserCredentials(
    ({
      String hashedPassword,
      PecuniaUser user,
    }) args,
  ) {
    return TaskEither.tryCatch(
      () async {
        await flutterSecureStorage.write(
            key: kPecuniaUserKey(args.user.uid), value: jsonEncode(args.user.toJson()));
        await flutterSecureStorage.write(
            key: kPecuniaUserHashedPasswordKey(args.user.uid), value: args.hashedPassword);
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

  /// Retrieves the user credentials (uid, hashedPassword) associated with the given email address.
  ///
  /// 1. Returns [AuthFailure] of type [AuthErrorType.incorrectCredentials] if no user is found with the given email
  /// 2. Returns [AuthFailure] of type [AuthErrorType.localMissingHashedPassword] if a user is found but no hashed password is found.
  /// 3. Returns [AuthFailure] of type [AuthErrorType.localFailedGetUserCredentials] if something else went wrong.
  TaskEither<AuthFailure, ({String uid, String hashedPassword, String? salt})> getUserCredentials(
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
        if (r.hashedPassword == null) {
          return TaskEither.left(AuthFailure(
            stackTrace: StackTrace.current,
            errorType: AuthErrorType.localMissingHashedPassword,
            message: 'User with uid $uid was found but no hashed password was found.',
          ));
        }
        return TaskEither.right((uid: r.uid, hashedPassword: r.hashedPassword!, salt: r.salt));
      }),
    );
  }
}
