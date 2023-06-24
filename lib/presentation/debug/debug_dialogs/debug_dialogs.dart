import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class DebugDialogsScreen extends ConsumerWidget {
  const DebugDialogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Dialogs'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            const SizedBox(height: 16),
            const FailureDialog(
              title: 'A one-liner goes a long way',
            ),
            const SizedBox(height: 10),
            const FailureDialog(
              title: 'You kinda messed up.',
              message: 'Like seriously what did you do',
            ),
            const SizedBox(height: 10),
            const SuccessDialog(
              title: "You didn't mess up this time",
              message: 'Congratulations, the UN should give you a medal of appreciation of participation.',
            ),
            const SizedBox(height: 10),
            const SuccessDialog(
              title: 'She said one line was enough...',
            ),
            const SizedBox(height: 10),
            ConfirmationDialog(
              title: 'Are you sure you want to do this?',
              onConfirm: () {},
            ),
            const SizedBox(height: 10),
            ConfirmationDialog(
              title: "You really can't undo whatever you're doing right now",
              message: 'So you better be completely sure',
              onConfirm: () {},
            )
          ],
        ),
      ),
    );
  }
}
