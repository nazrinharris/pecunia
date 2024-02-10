import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/app_info_errors/app_info_errors.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_info_local_ds.g.dart';

@riverpod
AppInfoLocalDS appInfoLocalDS(AppInfoLocalDSRef ref) => AppInfoLocalDS(
      ref.watch(pecuniaSharedPreferencesProvider).requireValue,
    );

class AppInfoLocalDS {
  AppInfoLocalDS(this.prefs);

  final SharedPreferences prefs;

  TaskEither<AppInfoFailure, Option<bool>> getIsFirstOpen() {
    return TaskEither.tryCatch(
      () async {
        final isFirstOpen = prefs.getBool(kPrefsIsFirstOpen);
        if (isFirstOpen == null) {
          await prefs.setBool(kPrefsIsFirstOpen, false);
          return const Option.of(true);
        }
        return Option.of(isFirstOpen);
      },
      (err, stackTrace) => AppInfoFailure(
        stackTrace: stackTrace,
        message: AppInfoErrorType.failedGetIsFirstOpen.message,
        errorType: AppInfoErrorType.failedGetIsFirstOpen,
      ),
    );
  }

  TaskEither<AppInfoFailure, Unit> setIsFirstOpen(bool value) {
    return TaskEither.tryCatch(
      () async {
        await prefs.setBool(kPrefsIsFirstOpen, value);
        return unit;
      },
      (err, stackTrace) => AppInfoFailure(
        stackTrace: stackTrace,
        message: AppInfoErrorType.failedSetIsFirstOpen.message,
        errorType: AppInfoErrorType.failedSetIsFirstOpen,
      ),
    );
  }
}
