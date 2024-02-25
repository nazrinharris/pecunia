import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'login_with_password.g.dart';

typedef LoginParams = ({
  String email,
  String password,
});

@riverpod
class LoginWithEmailAndPassword extends _$LoginWithEmailAndPassword {
  @override
  FutureOr<Option<PecuniaUser>> build() {
    return const Option.none();
  }

  Future<void> loginWithEmailAndPassword(LoginParams loginParams) async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref
        .read(authRepoProvider)
        .loginWithPassword(
          email: loginParams.email,
          password: loginParams.password,
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

  Future<void> updateProviderUserValue() async {
    state = const AsyncLoading();

    final failureOrPecuniaUser = await ref.read(authRepoProvider).getLoggedInUser().run();

    failureOrPecuniaUser.fold(
      (failure) {
        if (failure.errorType == AuthErrorType.noLoggedInUser) {
          state = const AsyncValue.data(Option.none());
        } else {
          state = AsyncValue.error(failure, failure.stackTrace);
        }
      },
      (pecuniaUser) => state = AsyncValue.data(pecuniaUser),
    );
  }
}
