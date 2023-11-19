import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_ds.g.dart';

@riverpod
AuthLocalDS authLocalDS(AuthLocalDSRef ref) => AuthLocalDS(
      ref.watch(pecuniaSharedPreferencesProvider).requireValue,
    );

class AuthLocalDS {
  AuthLocalDS(this.prefs);

  final SharedPreferences prefs;

  /// `storeSavedUser` method is used to record in [kPrefsSavedUsers] that a user has once logged in
  /// or registered, and their data is still on the app. If the user logs out, their
  /// record should persist, unless they choose to clear their data.
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
}
