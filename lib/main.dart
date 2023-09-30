import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:full_screen_dialog_manager/full_screen_dialog_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/util/logger.dart';
import 'package:pecunia/presentation/router/router.dart';
import 'package:positioned_dialog_manager/positioned_dialog_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

const bool isDebugMode = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await supa.Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0cmtsdWdtbHBuaHljbWtsbnd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzk2Mjg5ODMsImV4cCI6MTk5NTIwNDk4M30.qQJ-HDOJJFSfSiiOQsZZF8S_HHx09uMWcxEnhfX4eiw',
    url: 'https://ptrklugmlpnhycmklnwx.supabase.co',
  );

  runApp(ProviderScope(
    observers: [
      ProviderLogger(),
    ],
    child: const PecuniaApp(),
  ));
}

class PecuniaApp extends StatelessWidget {
  const PecuniaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: ThemeData.dark(useMaterial3: true).textTheme.apply(fontFamily: 'Subjectivity')),
      themeMode: ThemeMode.dark,
      title: 'Pecunia',
      routerConfig: router,
      builder: FlutterEasyDialogs.builder(
        setupManagers: (overlayController, managerRegistry) {
          managerRegistry
            ..registerFullScreen(overlayController)
            ..registerPositioned(overlayController);
        },
      ),
    );
  }
}

/// This comment is just for initial commits for new branches. A cool history so to speak.
/// 
/// Comment for testing local database: test-local-db
/// Comment for internal improvements: internal-improvements
/// Comment for accounts feature - accounts-feature
/// Comment for transactions feature - transactions-feature
/// Comment for tests for accounts and transactions
/// Comment for multi-currency and transfer feature - multi-currency-and-transfer-feature
/// Comment for transaction categories feature - transaction-categories
/// Comment for UI general usability - ui-general-usability

