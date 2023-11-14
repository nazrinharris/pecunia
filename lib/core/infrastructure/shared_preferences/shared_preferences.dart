import 'package:pecunia/core/errors/app_info_errors/app_info_errors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
class PecuniaSharedPreferences extends _$PecuniaSharedPreferences {
  @override
  Future<SharedPreferences> build() async {
    try {
      return await SharedPreferences.getInstance();
    } catch (e) {
      return Future.error(
        AppInfoFailure(
          stackTrace: StackTrace.current,
          message: AppInfoErrorType.errorGettingSharedPrefs.message,
          errorType: AppInfoErrorType.errorGettingSharedPrefs,
        ),
      );
    }
  }
}
