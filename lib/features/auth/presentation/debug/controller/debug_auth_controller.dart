import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_controller.g.dart';

@riverpod
class DebugAuthController extends _$DebugAuthController {
  @override
  FutureOr<void> build() {
    // no operation
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}
}
