import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_auth_providers.g.dart';

typedef LoginParams = ({String email, String password, Session currentSession});

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
}
