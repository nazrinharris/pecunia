import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout.g.dart';

@riverpod
class Logout extends _$Logout {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> logout(String uid) async {
    state = const AsyncValue.loading();

    (await ref.watch(authRepoProvider).logout(uid).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = const AsyncData(Option.of(unit)),
    );
  }
}
