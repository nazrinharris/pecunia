import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_register_with_email_and_password.g.dart';

@riverpod
class LocalRegisterWithEmailAndPassword extends _$LocalRegisterWithEmailAndPassword {
  @override
  Future<Option<PecuniaUser>> build() async {
    return const Option.none();
  }

  Future<void> localRegisterWithEmailAndPassword({
    required String username,
    required String email,
    required String confirmPassword,
  }) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .localRegisterWithEmailAndPassword(
          email: email,
          username: username,
          password: confirmPassword,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.user)),
    );
  }
}
