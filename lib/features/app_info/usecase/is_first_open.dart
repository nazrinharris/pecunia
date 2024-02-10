import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/app_info/domain/app_info_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_first_open.g.dart';

@riverpod
class IsFirstOpen extends _$IsFirstOpen {
  @override
  Future<Option<bool>> build() async {
    return none();
  }

  Future<void> getIsFirstOpen() async => (await ref.watch(appInfoRepoProvider).getIsFirstOpen().run()).match(
        (f) => state = AsyncError(f, f.stackTrace),
        (r) => state = AsyncData(r),
      );

  Future<void> setIsFirstOpen(bool value) async =>
      (await ref.watch(appInfoRepoProvider).setIsFirstOpen(value).run()).match(
        (f) => state = AsyncError(f, f.stackTrace),
        (_) => state = AsyncData(Option.of(value)),
      );
}
