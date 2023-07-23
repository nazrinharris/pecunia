import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_providers.g.dart';

@riverpod
class NavigateToDebugLocalDB extends _$NavigateToDebugLocalDB {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> navigateToDebugLocalDB() async {
    state = const AsyncValue.loading();
    (await ref.read(authRepoProvider).getLoggedInUser().run()).fold(
      (l) {
        state = AsyncValue.error(l, l.stackTrace);
      },
      (r) {
        state = const AsyncValue.data(true);
      },
    );
  }
}
