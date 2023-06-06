import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/features/auth/domain/models/pecunia_user.dart';

class DebugLoginAndRegisterScreen extends StatelessWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailLoginController = TextEditingController();
    final passwordLoginController = TextEditingController();

    final emailRegisterController = TextEditingController();
    final usernameRegisterController = TextEditingController();
    final passwordRegisterController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Login & Register'),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            const SizedBox(height: 50),
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
    );
  }
}

final debugLoginAndRegisterProvider = StateNotifierProvider(
  (ref) => DebugLoginAndRegisterNotifier(),
);

class DebugLoginAndRegisterNotifier
    extends StateNotifier<(PecuniaUser? registeredUser, PecuniaUser? loggedInUser)> {
  DebugLoginAndRegisterNotifier() : super((null, null));

  void updateLogin(PecuniaUser loggedInUser) {
    state = (state.$1, loggedInUser);
  }

  void updateRegister(PecuniaUser registeredUser) {
    state = (registeredUser, state.$2);
  }
}
