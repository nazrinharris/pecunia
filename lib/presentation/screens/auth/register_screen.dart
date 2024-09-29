import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/local_register_with_email_and_password.dart';
import 'package:pecunia/features/auth/usecases/register_with_password.dart';
import 'package:pecunia/presentation/screens/auth/login_screen.dart';
import 'package:pecunia/presentation/widgets/common/scale_button.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(registerWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't register you.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref
            ..invalidate(pecuniaDBProvider)
            ..watch(pecuniaDBProvider);
          context.goNamed('main');
        }
      })
      ..listen(localRegisterWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't register you.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref
            ..invalidate(pecuniaDBProvider)
            ..watch(pecuniaDBProvider)
            ..listenManual(pecuniaDBProvider, (previous, next) async {
              switch (next) {
                case AsyncLoading():
                  debugPrint('Loading PecuniaDB');
                case AsyncData():
                  context.goNamed('main');
                case AsyncError(:final Failure error):
                  await ref
                      .read(pecuniaDialogsProvider)
                      .showFailureDialog(context, failure: error, title: 'Database Error Occured');
                case _:
                  await ref.read(pecuniaDialogsProvider).showFailureDialog(context,
                      title: 'Unexpected State',
                      message: 'An unexpected state was emitted when loading up the database');
              }
            });
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
            const RegisterHeader(),
            const SizedBox(height: 24),
            Divider(color: Theme.of(context).dividerColor.withOpacity(0.1)),
            const RegisterForm(),
          ],
        ));
  }
}

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Register 👋',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ScaleButton(
                onTap: () {
                  context.go('/start/login');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 96),
            child: Text(
              "Hey there! Welcome to Pecunia, your personal finance manager. Let's get started!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
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

    final localBool = useState(false);

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            LocalAccountToggle(
              localBool,
              message:
                  'This will create a local user account on your device. This account will not be saved in the remote database and will be deleted if you uninstall the app.',
            ),
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
                  if (localBool.value == false) {
                    ref.read(registerWithEmailAndPasswordProvider.notifier).registerWithEmailAndPassword((
                      email: emailController.text,
                      username: usernameController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                    ));
                  } else {
                    ref
                        .read(localRegisterWithEmailAndPasswordProvider.notifier)
                        .localRegisterWithEmailAndPassword(
                          email: emailController.text,
                          username: usernameController.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                  }
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
