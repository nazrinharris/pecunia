import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/presentation/debug/debug_accounts/edit_account/debug_edit_account_screen.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:pecunia/presentation/debug/debug_auth/debug_login_register_screen.dart';
import 'package:pecunia/presentation/debug/debug_dialogs/debug_dialogs.dart';
import 'package:pecunia/presentation/debug/debug_local_db/debug_local_db_screen.dart';
import 'package:pecunia/presentation/debug/debug_transactions/debug_transactions_screen.dart';
import 'package:pecunia/presentation/screens/auth/login_screen.dart';
import 'package:pecunia/presentation/screens/auth/register_screen.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories_screen.dart';
import 'package:pecunia/presentation/screens/entry_screen.dart';
import 'package:pecunia/presentation/screens/main_screen.dart';
import 'package:pecunia/presentation/screens/settings_screen.dart';
import 'package:pecunia/presentation/screens/start_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EntryScreen(),
    ),
    GoRoute(
      path: '/start',
      name: 'start',
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    // Debug Routes
    GoRoute(
      path: '/debug-login',
      name: 'debug-login',
      builder: (context, state) => const DebugLoginAndRegisterScreen(),
    ),
    GoRoute(
      path: '/debug-local-db',
      name: 'debug-local-db',
      builder: (context, state) => const DebugLocalDBScreen(),
    ),
    GoRoute(
      path: '/debug-dialogs',
      name: 'debug-dialogs',
      builder: (context, state) => const DebugDialogsScreen(),
    ),
    GoRoute(
      path: '/drift-db-viewer',
      name: 'drift-db-viewer',
      builder: (context, state) {
        final db = state.extra! as PecuniaDB;
        return DriftDbViewer(db);
      },
    ),
    GoRoute(
      path: '/debug-edit-account',
      name: 'debug-edit-account',
      builder: (context, state) {
        final account = state.extra! as Account;
        return DebugEditAccountScreen(account);
      },
    ),
    GoRoute(
      path: '/debug-view-account',
      name: 'debug-view-account',
      builder: (context, state) {
        final account = state.extra! as Account;
        return DebugViewAccountScreen(account.id);
      },
    ),
    GoRoute(
      path: '/debug-transactions',
      name: 'debug-transactions',
      builder: (context, state) => const DebugTransactionsScreen(),
    ),
    GoRoute(
      path: '/view-all-categories',
      name: 'view-all-categories',
      builder: (context, state) => const ViewAllCategories(),
    ),
  ],
);
