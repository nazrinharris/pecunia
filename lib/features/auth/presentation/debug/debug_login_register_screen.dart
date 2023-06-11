import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/features/auth/presentation/debug/form/debug_form.dart';
import 'package:pecunia/features/auth/presentation/debug/providers/debug_auth_providers.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebugLoginAndRegisterScreen extends HookConsumerWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Login & Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: const [
              LoginForm(),
              LoginDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveForm(
      formGroup: loginForm,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'email',
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          ReactiveTextField<String>(
            formControlName: 'password',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 16),
          ReactiveFormConsumer(
            builder: (context, form, child) {
              return ElevatedButton(
                onPressed: form.valid
                    ? () => ref.read(loginWithEmailAndPasswordProvider.notifier).loginWithEmailAndPassword((
                          email: form.value['email']! as String,
                          password: form.value['password']! as String,
                          currentSession: const Session(isValid: false),
                        ))
                    : null,
                child: const Text('Login'),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              await ref.read(authRepoProvider).logout(const Session(isValid: true)).run();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class LoginDetails extends HookConsumerWidget {
  const LoginDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginWithEmailAndPasswordProvider);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: state.when(
          data: (data) {
            return Column(
              children: [
                Text(data.toString()),
              ],
            );
          },
          error: (e, stack) {
            final error = e as Failure;
            return Column(
              children: [
                Text(error.message),
              ],
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}