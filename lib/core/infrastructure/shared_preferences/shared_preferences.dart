import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
class PecuniaSharedPreferences extends _$PecuniaSharedPreferences {
  @override
  Future<SharedPreferences> build() async {
    return SharedPreferences.getInstance();
  }
}
