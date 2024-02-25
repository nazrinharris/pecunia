import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_with_password.g.dart';

typedef RegisterParams = ({
  String email,
  String username,
  String password,
  String confirmPassword,
});

@riverpod
class RegisterWithEmailAndPassword extends _$RegisterWithEmailAndPassword {
  @override
  FutureOr<Option<PecuniaUser>> build() {
    return const Option.none();
  }

  Future<void> registerWithEmailAndPassword(RegisterParams registerParams) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .registerWithPassword(
          email: registerParams.email,
          username: registerParams.username,
          password: registerParams.confirmPassword,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.user)),
    );
  }

  void reset() {
    state = const AsyncValue.data(Option.none());
  }
}
