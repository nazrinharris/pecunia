import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/features/auth/usecases/login_with_password.dart';
import 'package:pecunia/features/auth/usecases/register_with_password.dart';
import 'package:pecunia/presentation/debug/debug_auth/debug_auth_providers.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class DebugLoginAndRegisterScreen extends HookConsumerWidget {
  const DebugLoginAndRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<bool>>(navigateToDebugLocalDBProvider, (prev, next) {
        if (next.runtimeType == AsyncData<bool>) {
          next.value!
              ? context.pushNamed('debug-local-db')
              : debugPrint(
                  'Not navigating to debug local db',
                );
        }

        if (next.runtimeType == AsyncError<bool>) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: 'You cannot navigate to DebugLocalDB',
                failure: next.error as AuthFailure?,
              );
        }
      })
      ..listen(loginWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't log you in.",
                failure: next.error as AuthFailure?,
              );
        }
      })
      ..listen(registerWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "We couldn't register an account for you.",
                failure: next.error as AuthFailure?,
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
    final formKey = useState(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Form(
      key: formKey.value,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(width: 14),
              ElevatedButton(
                onPressed: () =>
                    ref.read(loginWithEmailAndPasswordProvider.notifier).updateProviderUserValue(),
                child: const Text('Update User Value'),
              ),
            ],
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
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }
}

class RegisterFields {
  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an email';
    }
    if (!EmailValidator.validate(val)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateUsername(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a username';
    }
    if (val.length < 5) {
      return 'Please enter a username with at least 5 characters';
    }
    return null;
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a password';
    }
    if (val.length < 6) {
      return 'Please enter a password with at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'Please confirm your password';
    }
    if (val != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    return Form(
      key: formKey.value,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: RegisterFields.validateEmail,
          ),
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: RegisterFields.validateUsername,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: RegisterFields.validatePassword,
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
            validator: (val) => RegisterFields.validateConfirmPassword(val, passwordController.text),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.value.currentState!.validate()) {
                ref.read(registerWithEmailAndPasswordProvider.notifier).registerWithEmailAndPassword((
                  email: emailController.text,
                  username: usernameController.text,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  currentSession: const Session(isValid: false),
                ));
              }
            },
            child: const Text('Register'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 83, 10, 10)),
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
                  backgroundColor: MaterialStateProperty.all(Colors.purple[900]),
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
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }
}
