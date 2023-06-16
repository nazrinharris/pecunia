import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/util/logger.dart';
import 'package:pecunia/presentation/router/router.dart';
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
      title: 'Pecunia',
      // home: EntryScreen(),
      routerConfig: router,
    );
  }
}

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();
    if (isDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/debug-login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// This comment is just for initial commits for new branches. A cool history so to speak.
/// 
/// Comment for testing local database: test-local-db
/// Comment for internal improvements: internal-improvements

