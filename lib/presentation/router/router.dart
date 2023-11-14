import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/presentation/debug/debug_auth/debug_login_register_screen.dart';
import 'package:pecunia/presentation/debug/debug_local_db/debug_local_db_screen.dart';
import 'package:pecunia/presentation/debug/debug_transactions/debug_transactions_screen.dart';
import 'package:pecunia/presentation/screens/accounts/edit_account_screen.dart';
import 'package:pecunia/presentation/screens/accounts/view_account_screen.dart';
import 'package:pecunia/presentation/screens/auth/login_screen.dart';
import 'package:pecunia/presentation/screens/auth/register_screen.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories_screen.dart';
import 'package:pecunia/presentation/screens/entry_screen.dart';
import 'package:pecunia/presentation/screens/main_screen.dart';
import 'package:pecunia/presentation/screens/onboarding_screen.dart';
import 'package:pecunia/presentation/screens/settings_screen.dart';
import 'package:pecunia/presentation/screens/start_screen.dart';
import 'package:pecunia/presentation/screens/transactions/recent_txns_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EntryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/start',
      name: 'start',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const StartScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MainScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/view-account',
      name: 'view-account',
      builder: (context, state) {
        final account = state.extra! as Account;
        return ViewAccountScreen(account.id);
      },
    ),
    GoRoute(
      path: '/recent-txns',
      name: 'recent-txns',
      builder: (context, state) => const RecentTxnsScreen(),
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
        return EditAccountScreen(account);
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
