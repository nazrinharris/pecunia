import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';

class DebugLoginAndRegisterScreen extends ConsumerWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailLoginController = TextEditingController();
    final passwordLoginController = TextEditingController();

    final emailRegisterController = TextEditingController();
    final usernameRegisterController = TextEditingController();
    final passwordRegisterController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Login & Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(height: 30),
              const Text('Login Here'),
              TextField(
                controller: emailLoginController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordLoginController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
              const SizedBox(height: 100),
              const Text('Register Here'),
              TextField(
                controller: emailRegisterController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: usernameRegisterController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: passwordRegisterController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
