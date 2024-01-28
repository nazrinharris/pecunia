// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/app_info/app_info.dart';
import 'package:pecunia/features/auth/usecases/get_logged_in_user.dart';
import 'package:pecunia/features/auth/usecases/maybe_migrate_pecunia_user.dart';
import 'package:pecunia/main.dart';

class EntryScreen extends StatefulHookConsumerWidget {
  const EntryScreen({super.key});

  @override
  ConsumerState<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  @override
  void initState() {
    super.initState();
    if (isDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await ref.watch(getLoggedInUserProvider.future).then((maybeUser) {
          maybeUser.match(
            () async {
              debugPrint('No user logged in, checking if first open');
              try {
                await ref
                    .watch(getIsFirstOpenProvider.future)
                    .then((maybeIsFirstOpen) => maybeIsFirstOpen.match(
                          () => unit,
                          (isFirstOpen) =>
                              isFirstOpen ? context.goNamed('onboarding') : context.goNamed('start'),
                        ));
              } catch (e) {
                // This is handled in the build method. If the try-catch is not here, it's
                // kind of considered a non-caught exception.
              }
            },
            (user) async {
              debugPrint('User logged in, maybe migrating user');

              ref
                ..invalidate(pecuniaDBProvider)
                ..watch(pecuniaDBProvider);

              await ref.read(maybeMigratePecuniaUserProvider.notifier).maybeMigratePecuniaUser();
            },
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(
        getIsFirstOpenProvider,
        (previous, next) {
          switch (next) {
            case AsyncError(:final Failure error):
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                      'Oops! We encountered an issue while setting up your app for the first time'),
                  content: Text(error.message),
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
            case AsyncError(:final Exception error):
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                      'Oops! We encountered an issue while setting up your app for the first time'),
                  content: Text(error.toString()),
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
          }
        },
      )
      ..listen(maybeMigratePecuniaUserProvider, (previous, next) {
        if (next is AsyncError) {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Oops! We encountered an issue while migrating your account data'),
              content: Text(next.error.toString()),
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
        }

        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          debugPrint('Checking for user migration complete, going to main');
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
