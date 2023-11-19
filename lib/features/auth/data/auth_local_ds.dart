import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
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

  TaskEither<AuthFailure, Unit> storeLoggedInUser(PecuniaUser user) {
    return TaskEither.tryCatch(
      () async {
        await prefs.setString(user.uid, user.username);
        return unit;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.cannotStoreLoggedInUser.message,
        errorType: AuthErrorType.cannotStoreLoggedInUser,
        rawException: e,
      ),
    );
  }

  TaskEither<AuthFailure, Unit> removeLoggedInUser(String uid) {
    return TaskEither.tryCatch(
      () async {
        await prefs.remove(uid);
        return unit;
      },
      (e, s) => AuthFailure(
        stackTrace: s,
        message: AuthErrorType.cannotRemoveLoggedInUser.message,
        errorType: AuthErrorType.cannotRemoveLoggedInUser,
        rawException: e,
      ),
    );
  }
}
