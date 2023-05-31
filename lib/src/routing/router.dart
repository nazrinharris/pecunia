// ignore_for_file: prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:pecunia/main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => EntryScreen(),
    ),
    // Debug Routes
  ],
);
