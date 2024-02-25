import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_login_with_email_and_password.g.dart';

@riverpod
class LocalLoginWithEmailAndPassword extends _$LocalLoginWithEmailAndPassword {
  @override
  Future<Option<PecuniaUser>> build() async {
    return const Option.none();
  }

  Future<void> localLoginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .localLoginWithEmailAndPassword(
          email: email,
          password: password,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.user)),
    );
  }
}
