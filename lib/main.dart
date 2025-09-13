import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/infrastructure/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences.dart';
import 'package:pecunia/core/util/logger.dart';
import 'package:pecunia/presentation/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

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

class PecuniaApp extends ConsumerStatefulWidget {
  const PecuniaApp({super.key});

  @override
  ConsumerState<PecuniaApp> createState() => _PecuniaAppState();
}

class _PecuniaAppState extends ConsumerState<PecuniaApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: Maybe implement eager initialization to avoid unnecessary rebuilds and error handling
    ref
      ..watch(pecuniaSharedPreferencesProvider)
      ..watch(pecuniaFlutterSecureStorageProvider);

    return MaterialApp.router(
      darkTheme: ThemeData.dark().copyWith(textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Nohemi')),
      // darkTheme: ThemeData.dark(
      //   useMaterial3: true,
      // ).copyWith(
      //   textTheme: ThemeData.dark(useMaterial3: true).textTheme.apply(fontFamily: 'Nohemi'),
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Color(0xFF383838),
      //     onPrimary: Color(0xFFFFFFFF),
      //     secondary: Color(0xFF111111),
      //     onSecondary: Color(0xFFFFFFFF),
      //     error: Colors.purple,
      //     onError: Colors.purple,
      //     surface: Color(0xFF0D0D0D),
      //     onSurface: Color(0xFFD9D9D9),
      //   ),
      //   elevatedButtonTheme: const ElevatedButtonThemeData(
      //       style: ButtonStyle(
      //     backgroundColor: WidgetStatePropertyAll(Color(0xFF383838)),
      //     splashFactory: InkRipple.splashFactory,
      //   )),
      // ),
      themeMode: ThemeMode.dark,
      title: 'Pecunia',
      routerConfig: router,
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
/// Comment for version management - version-management
/// Comment for local/guest account - local-guest-account
