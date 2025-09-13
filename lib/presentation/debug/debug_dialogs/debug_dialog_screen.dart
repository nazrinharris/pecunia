// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';

class DebugDialogScreen extends ConsumerWidget {
  const DebugDialogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Dialogs'),
      ),
      body: ListView(
        children: [
          TextEntryConfirmationDialog(
            title: 'This is a very dangerous action',
            description:
                'By going forward, you will delete all your data. Are you sure you want to continue?',
            entryConfirmationText: 'DELETE ALL DATA',
            onConfirm: () {},
            onCancel: () {},
          ),
        ],
      ),
    );
  }
}
