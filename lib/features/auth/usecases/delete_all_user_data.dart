import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_all_user_data.g.dart';

@riverpod
class DeleteAllUserData extends _$DeleteAllUserData {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteAllUserData() async {
    state = const AsyncValue.loading();

    (await ref.watch(authRepoProvider).deleteAllUserData(ref.watch(pecuniaDBProvider).requireValue).run())
        .fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (_) => state = const AsyncData(Option.of(unit)),
    );
  }
}
