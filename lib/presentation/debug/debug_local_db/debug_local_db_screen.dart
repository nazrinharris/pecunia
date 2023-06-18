import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

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
            const SizedBox(height: 14),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed('drift-db-viewer', extra: ref.read(pecuniaDBProvider));
                },
                child: const Text('Inspect DB'),
              ),
            ),
            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 7),
            const Align(
              child: Text(
                'flutter_easy_dialogs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              alignment: Alignment.center,
              height: 50,
              child: ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(pecuniaDialogsProvider).showDebugPositionedDialog();
                    },
                    child: const Text('Show Positioned Dialog'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(pecuniaDialogsProvider).showDebugFullScreenDialog();
                    },
                    child: const Text('Show Full Screen Dialog'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 61, 14, 11)),
                    ),
                    onPressed: () {
                      ref.read(pecuniaDialogsProvider).showFailureDialog(
                              failure: AuthFailure(
                            stackTrace: StackTrace.current,
                            message: AuthErrorType.unknown.message,
                            authAction: AuthAction.unknown,
                            errorType: AuthErrorType.unknown,
                          ));
                    },
                    child: const Text('Show Failure Screen Dialog'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Divider(),
          ],
        ));
  }
}
