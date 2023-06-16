import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/auth_errors/auth_failures.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_providers.g.dart';

typedef LoginParams = ({
  String email,
  String password,
  Session currentSession,
});
typedef RegisterParams = ({
  String email,
  String username,
  String password,
  String confirmPassword,
  Session currentSession,
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
          currentSession: loginParams.currentSession,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.pecuniaUser)),
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
        if (failure is NoLoggedInUserFailure) {
          state = const AsyncValue.data(Option.none());
        } else {
          state = AsyncValue.error(failure, failure.stackTrace);
        }
      },
      (pecuniaUser) => state = AsyncValue.data(Option.of(pecuniaUser)),
    );
  }
}

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
          currentSession: registerParams.currentSession,
        )
        .run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r.pecuniaUser)),
    );
  }

  void reset() {
    state = const AsyncValue.data(Option.none());
  }
}

@riverpod
class NavigateToDebugLocalDB extends _$NavigateToDebugLocalDB {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> navigateToDebugLocalDB() async {
    state = const AsyncValue.loading();
    final result = await ref.read(authRepoProvider).getLoggedInUser().run();

    result.fold(
      (l) {
        state = AsyncValue.error(l, l.stackTrace);
      },
      (r) {
        state = const AsyncValue.data(true);
      },
    );
  }
}
