import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/presentation/debug/debug_auth/form/debug_form.dart';
import 'package:pecunia/presentation/debug/debug_auth/providers/debug_auth_providers.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DebugLoginAndRegisterScreen extends HookConsumerWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(navigateToDebugLocalDBProvider, (prev, next) {
      if (next.runtimeType == AsyncData<bool>) {
        next.value!
            ? context.pushNamed('debug-local-db')
            : debugPrint(
                'Not navigating to debug local db',
              );
      }
    });

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
              RegisterForm(),
              RegisterDetails(),
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: form.valid
                        ? () =>
                            ref.read(loginWithEmailAndPasswordProvider.notifier).loginWithEmailAndPassword((
                              email: form.value['email']! as String,
                              password: form.value['password']! as String,
                              currentSession: const Session(isValid: false),
                            ))
                        : null,
                    child: const Text('Login'),
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(loginWithEmailAndPasswordProvider.notifier).updateProviderUserValue(),
                    child: const Text('Update User Value'),
                  ),
                ],
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
    final state = ref.watch(loginWithEmailAndPasswordProvider);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
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

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveForm(
      formGroup: registerForm,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'email',
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          ReactiveTextField<String>(
            formControlName: 'username',
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          ReactiveTextField<String>(
            formControlName: 'password',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          ReactiveTextField<String>(
            formControlName: 'confirmPassword',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
          ),
          const SizedBox(height: 16),
          ReactiveFormConsumer(
            builder: (context, form, child) {
              return ElevatedButton(
                onPressed: form.valid
                    ? () =>
                        ref.read(registerWithEmailAndPasswordProvider.notifier).registerWithEmailAndPassword((
                          email: form.value['email']! as String,
                          username: form.value['username']! as String,
                          password: form.value['password']! as String,
                          confirmPassword: form.value['confirmPassword']! as String,
                          currentSession: const Session(isValid: false),
                        ))
                    : null,
                child: const Text('Register'),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  await ref.read(authRepoProvider).logout(const Session(isValid: true)).run();
                  ref.read(loginWithEmailAndPasswordProvider.notifier).reset();
                  ref.read(registerWithEmailAndPasswordProvider.notifier).reset();
                },
                child: const Text('Logout'),
              ),
              const SizedBox(width: 14),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () => ref.read(navigateToDebugLocalDBProvider.notifier).navigateToDebugLocalDB(),
                child: const Text('Go to Debug Local Storage'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterDetails extends HookConsumerWidget {
  const RegisterDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() => null, const []);

    final state = ref.watch(registerWithEmailAndPasswordProvider);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
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
