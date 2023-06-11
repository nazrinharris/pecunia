// ignore_for_file: prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:pecunia/features/auth/presentation/debug/debug_login_register_screen.dart';
import 'package:pecunia/main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => EntryScreen(),
    ),
    // Debug Routes
    GoRoute(
      path: '/debug-login',
      builder: (context, state) => DebugLoginAndRegisterScreen(),
    ),
  ],
);
