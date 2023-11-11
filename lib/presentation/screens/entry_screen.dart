// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/auth/usecases/get_logged_in_user.dart';
import 'package:pecunia/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          final shared = await SharedPreferences.getInstance();
          final isFirstOpen = shared.getBool('is_first_open') ?? true;

          if (isFirstOpen) {
            await shared.setBool('is_first_open', false);
            context.goNamed('onboarding');
          } else {
            context.goNamed('start');
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox.shrink(),
      ),
    );
  }
}
