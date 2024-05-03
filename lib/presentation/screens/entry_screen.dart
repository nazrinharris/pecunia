import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/app_info_errors/app_info_errors.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/app_info/domain/app_info_repo.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/get_logged_in_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_screen.g.dart';
part 'entry_screen.freezed.dart';

@freezed
class EntryState with _$EntryState {
  const EntryState._();
  const factory EntryState.loading() = EntryLoading;
  const factory EntryState.noLoggedInUser(Option<bool> maybeIsFirstOpen) = NoLoggedInUser;
  const factory EntryState.completedEntry() = CompletedEntry;
  const factory EntryState.error(Failure failure) = EntryError;
}

@riverpod
class Entry extends _$Entry {
  @override
  Future<EntryState> build() async {
    return const EntryState.loading();
  }

  Future<void> entry() async {
    state = const AsyncLoading();

    (await _getLoggedInUser()).fold(
      (f) => state = AsyncError(EntryState.error(f), f.stackTrace),
      (maybeUser) async => maybeUser.match(
        () async => (await _getIsFirstOpen()).fold(
          (f) => state = AsyncError(f, f.stackTrace),
          (maybeIsFirstOpen) => state = AsyncData(EntryState.noLoggedInUser(maybeIsFirstOpen)),
        ),
        (maybeUser) async => (await _maybeMigrateUser()).fold(
          (f) => state = AsyncError(EntryState.error(f), f.stackTrace),
          (_) => state = const AsyncData(EntryState.completedEntry()),
        ),
      ),
    );
  }

  Future<Either<AuthFailure, Option<PecuniaUser>>> _getLoggedInUser() =>
      ref.read(authRepoProvider).getLoggedInUser().run();

  Future<Either<AppInfoFailure, Option<bool>>> _getIsFirstOpen() =>
      ref.read(appInfoRepoProvider).getIsFirstOpen().run();

  Future<Either<AuthFailure, Unit>> _maybeMigrateUser() =>
      ref.read(authRepoProvider).maybeMigratePecuniaUser().run();
}

class EntryScreen extends StatefulHookConsumerWidget {
  const EntryScreen({super.key});

  @override
  ConsumerState<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(entryProvider.notifier).entry();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(entryProvider, (previous, next) {
      if (next is AsyncError) {
        print((next.error! as EntryError).failure.rawException);
        print(next.error);
      }
      switch (next) {
        case AsyncError(error: final EntryError f):
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Oops! We encountered an issue while setting up your app for the first time'),
              content: Text(f.failure.message),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ).then((value) => context.goNamed('start'));
        case AsyncData(value: final NoLoggedInUser state):
          state.maybeIsFirstOpen.match(
            () => null,
            (isFirstOpen) => isFirstOpen ? context.goNamed('onboarding') : context.goNamed('start'),
          );
        case AsyncData(value: final CompletedEntry _):
          ref.invalidate(getLoggedInUserProvider);
          context.goNamed('main');
      }
    });

    return const Scaffold(
      body: Center(
        child: SizedBox.shrink(),
      ),
    );
  }
}
