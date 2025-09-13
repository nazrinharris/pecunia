import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'continue_as_guest.g.dart';

@riverpod
class ContinueAsGuest extends _$ContinueAsGuest {
  @override
  Future<Option<PecuniaUser>> build() async {
    return const Option.none();
  }

  Future<void> continueAsGuest() async {
    state = const AsyncValue.loading();

    final failureOrPecuniaUserAndSession = await ref.read(authRepoProvider).continueAsGuest().run();

    return failureOrPecuniaUserAndSession.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (r) => state = AsyncValue.data(Option.of(r)),
    );
  }
}
