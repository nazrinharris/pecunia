import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/main.dart';
import 'package:pecunia/presentation/debug/debug_auth/debug_login_register_screen.dart';
import 'package:pecunia/presentation/debug/debug_local_db/debug_local_db_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EntryScreen(),
    ),
    // Debug Routes
    GoRoute(
      path: '/debug-login',
      builder: (context, state) => const DebugLoginAndRegisterScreen(),
    ),
    GoRoute(
      path: '/debug-local-db',
      builder: (context, state) => const DebugLocalDBScreen(),
    ),
    GoRoute(
      path: '/drift-db-viewer',
      name: 'drift-db-viewer',
      builder: (context, state) {
        final db = state.extra! as PecuniaDB;
        return DriftDbViewer(db);
      },
    )
  ],
);
