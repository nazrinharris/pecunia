import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info.g.dart';

@riverpod
Future<Option<bool>> getIsFirstOpen(GetIsFirstOpenRef ref) async {
  final prefs = await ref.watch(pecuniaSharedPreferencesProvider.future);
  final isFirstOpen = prefs.getBool('is_first_open');
  if (isFirstOpen == null) {
    await prefs.setBool('is_first_open', false);
    return const Option.of(true);
  }
  return Option.of(isFirstOpen);
}

@riverpod
Future<void> setIsFirstOpen(SetIsFirstOpenRef ref, bool value) async {
  final prefs = await ref.watch(pecuniaSharedPreferencesProvider.future);
  await prefs.setBool('is_first_open', value);
}
