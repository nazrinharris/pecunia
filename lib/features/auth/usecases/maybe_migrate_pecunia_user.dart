import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maybe_migrate_pecunia_user.g.dart';

@riverpod
class MaybeMigratePecuniaUser extends _$MaybeMigratePecuniaUser {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> maybeMigratePecuniaUser() async {
    state = const AsyncValue.loading();

    (await ref.read(authRepoProvider).maybeMigratePecuniaUser().run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (_) => state = const AsyncData(Option.of(unit)),
    );
  }
}
