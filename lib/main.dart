// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pecunia/src/features/auth/domain/pecunia_user.dart';
import 'package:pecunia/src/routing/router.dart';
import 'package:pecunia/src/util/printer.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await supa.Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0cmtsdWdtbHBuaHljbWtsbnd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzk2Mjg5ODMsImV4cCI6MTk5NTIwNDk4M30.qQJ-HDOJJFSfSiiOQsZZF8S_HHx09uMWcxEnhfX4eiw",
      url: "https://ptrklugmlpnhycmklnwx.supabase.co");

  runApp(const PecuniaApp());
}

class PecuniaApp extends StatelessWidget {
  const PecuniaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pecunia",
      // home: EntryScreen(),
      routerConfig: router,
    );
  }
}

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pecunia Test"),
            ElevatedButton(
              onPressed: () {
                PecuniaUser user = PecuniaUser(
                  uid: "test_uid",
                  username: "test_username",
                  dateCreated: DateTime.now(),
                );

                prettyPrintJson(user.toJson());
              },
              child: Text("Press"),
            )
          ],
        ),
      ),
    );
  }
}
