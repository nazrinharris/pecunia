// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/app_info/app_info.dart';
import 'package:pecunia/features/auth/usecases/get_logged_in_user.dart';
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
        final result = await ref.watch(getLoggedInUserProvider.future);

        if (result.isSome()) {
          context.goNamed('main');
        } else {
          debugPrint('No user logged in, checking if first open');
          try {
            (await ref.watch(getIsFirstOpenProvider.future)).fold(() => null, (isFirstOpen) {
              if (isFirstOpen) {
                debugPrint('First open, showing onboarding');
                context.goNamed('onboarding');
              } else {
                debugPrint('Not first open, showing start');
                context.goNamed('start');
              }
            });
          } catch (e) {
            // Error is handled in the ref.listen
            debugPrint('Error while checking if first open: $e');
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      getIsFirstOpenProvider,
      (previous, next) {
        switch (next) {
          case AsyncError(:final Failure error):
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title:
                    const Text('Oops! We encountered an issue while setting up your app for the first time'),
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
                title:
                    const Text('Oops! We encountered an issue while setting up your app for the first time'),
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
    );

    return const Scaffold(
      body: Center(
        child: SizedBox.shrink(),
      ),
    );
  }
}
