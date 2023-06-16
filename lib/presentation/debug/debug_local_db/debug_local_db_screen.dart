import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';

class DebugLocalDBScreen extends ConsumerWidget {
  const DebugLocalDBScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Debug Local DB'),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('drift-db-viewer', extra: ref.read(pecuniaDBProvider));
                },
                child: const Text('Inspect DB'),
              ),
            )
          ],
        ));
  }
}
