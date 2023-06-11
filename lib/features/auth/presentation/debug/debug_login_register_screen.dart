import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/auth/presentation/debug/controller/debug_auth_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'form/debug_form.dart';

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
          ReactiveTextField(
            formControlName: 'email',
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          ReactiveTextField(
            formControlName: 'password',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          ReactiveFormConsumer(
            builder: (context, form, child) {
              return ElevatedButton(
                onPressed: form.valid
                    ? () => ref.read(debugAuthControllerProvider.notifier).loginWithEmailAndPassword(
                          email: form.value['email']! as String,
                          password: form.value['password']! as String,
                        )
                    : null,
                child: const Text('Login'),
              );
            },
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
    final state = ref.watch(debugAuthControllerProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: state.map(
        data: (data) {},
        error: (error) {},
        loading: (loading) {
          return Container(
            height: 200,
            width: 200,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
