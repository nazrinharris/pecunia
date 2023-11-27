// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/local_login_with_email_and_password.dart';
import 'package:pecunia/features/auth/usecases/login_with_password.dart';
import 'package:pecunia/presentation/widgets/common/scale_button.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(loginWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't log you in.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref.watch(pecuniaDBProvider);
          context.goNamed('main');
        }
      })
      ..listen(localLoginWithEmailAndPasswordProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureToast(
                context: context,
                title: "We couldn't log you in.",
                failure: next.error as AuthFailure?,
              );
        }
        if (next is AsyncData<Option<PecuniaUser>> && next.value.isSome()) {
          ref.watch(pecuniaDBProvider);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Login 👋',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ScaleButton(
                onTap: () {
                  context.go('/start/register');
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
                        'Register',
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

    final localBool = useState(false);

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            LocalAccountToggle(
              localBool,
              maxHeight: 70,
              message:
                  'Local user accounts are the accounts you have made on your current device. They are not stored in the remote database.',
            ),
            SizedBox(height: 14),
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
                  if (localBool.value == false) {
                    debugPrint('Login with remote');
                    ref.read(loginWithEmailAndPasswordProvider.notifier).loginWithEmailAndPassword((
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  } else {
                    debugPrint('Login with local');
                    ref.read(localLoginWithEmailAndPasswordProvider.notifier).localLoginWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
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

class LocalAccountToggle extends HookConsumerWidget {
  const LocalAccountToggle(
    this.localBool, {
    required this.message,
    this.maxHeight = 90,
    super.key,
  });

  final ValueNotifier<bool> localBool;
  final String message;
  final double maxHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = useState(Control.stop);

    localBool.addListener(() {
      if (localBool.value) {
        control.value = Control.play;
      } else {
        control.value = Control.playReverse;
      }
    });

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: () {
            localBool.value = !localBool.value;
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Use Local User Account',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Spacer(),
                    Switch(
                      value: localBool.value,
                      onChanged: (val) {
                        localBool.value = val;
                      },
                    ),
                  ],
                ),
                CustomAnimationBuilder(
                  control: control.value,
                  curve: Curves.easeInOutCirc,
                  tween: MovieTween()
                    ..tween(
                      'opacity',
                      Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 100),
                    )
                    ..tween(
                      'height',
                      Tween<double>(begin: 0, end: maxHeight),
                      duration: const Duration(milliseconds: 100),
                    ),
                  builder: (context, value, child) => Opacity(
                    opacity: value.get('opacity'),
                    child: SizedBox(
                      height: value.get('height'),
                      child: child,
                    ),
                  ),
                  duration: Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: Text(
                      message,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
