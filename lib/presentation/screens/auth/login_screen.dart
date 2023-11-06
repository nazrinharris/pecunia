// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/features/auth/usecases/login_with_password.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginWithEmailAndPasswordProvider, (prev, next) {
      if (next is AsyncError) {
        ref.read(pecuniaDialogsProvider).showFailureToast(
              context: context,
              title: "We couldn't log you in.",
              failure: next.error as AuthFailure?,
            );
      }
      if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
        context.goNamed('main');
      }
    });

    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            LoginHeader(),
            SizedBox(height: 24),
            Divider(color: Theme.of(context).dividerColor.withOpacity(0.1)),
            LoginForm(),
          ],
        ));
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login 👋',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 96),
            child: Text(
              'Welcome back to Pecunia, your personal finance manager.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (formKey.value.currentState!.validate()) {
                  ref.read(loginWithEmailAndPasswordProvider.notifier).loginWithEmailAndPassword((
                    email: emailController.text,
                    password: passwordController.text,
                    currentSession: const Session(isValid: false),
                  ));
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
