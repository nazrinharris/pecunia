import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDivider extends ConsumerWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(),
    );
  }
}
