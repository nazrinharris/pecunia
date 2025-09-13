import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/package_info/package_info.dart';
import 'package:pecunia/core/infrastructure/shared_preferences/shared_preferences_constants.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/continue_as_guest.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';

class StartScreen extends HookConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(continueAsGuestProvider, (prev, next) async {
      if (next is AsyncError) {
        await ref.read(pecuniaDialogsProvider).showFailureToast(
              context: context,
              title: "Couldn't continue as guest",
              failure: next.error as AuthFailure?,
            );
      }
      if (next is AsyncData<fp.Option<PecuniaUser>> && next.value.isSome()) {
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

    final control = useState(Control.play);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.bottom + 64),
            PecuniaLogo(control),
            const SizedBox(height: 10),
            WelcomeText(control),
            const Spacer(),
            DescriptionText(control),
            AuthButtons(control),
          ],
        ),
      ),
    );
  }
}

class PecuniaLogo extends StatefulWidget {
  const PecuniaLogo(this.control, {super.key});

  final ValueNotifier<Control> control;

  @override
  State<PecuniaLogo> createState() => _PecuniaLogoState();
}

class _PecuniaLogoState extends State<PecuniaLogo> {
  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder(
      control: widget.control.value,
      tween: MovieTween()
        ..tween(
          'opacity',
          Tween<double>(begin: 0, end: 1),
          curve: Curves.easeOutQuad,
          duration: const Duration(milliseconds: 500),
        )
        ..tween(
          'position',
          Tween<Offset>(begin: const Offset(0, 150), end: Offset.zero),
          curve: Curves.easeOutQuad,
          duration: const Duration(milliseconds: 1000),
        )
        ..tween(
          'size',
          Tween<double>(begin: 1.5, end: 1),
          curve: Curves.easeOutQuad,
          duration: const Duration(milliseconds: 500),
        ),
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'),
          child: Transform.translate(
            offset: value.get('position'),
            child: Transform.scale(
              scale: value.get('size'),
              child: child,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset('assets/app_icon/icon_transparent.png'),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText(this.control, {super.key});

  final ValueNotifier<Control> control;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAnimationBuilder(
          control: control.value,
          tween: MovieTween()
            ..tween(
              'opacity',
              Tween<double>(begin: 0, end: 1),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            )
            ..tween(
              'position',
              Tween<Offset>(begin: const Offset(0, 70), end: Offset.zero),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            )
            ..tween(
              'scale',
              Tween<double>(begin: 1.2, end: 1),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            ),
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 700),
          builder: (context, value, child) {
            return Opacity(
              opacity: value.get('opacity'),
              child: Transform.translate(
                offset: value.get('position'),
                child: Transform.scale(
                  scale: value.get('scale'),
                  child: child,
                ),
              ),
            );
          },
          child: Transform.translate(
            offset: const Offset(0, 10),
            child: Text(
              'Welcome to',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Instrument',
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ),
            ),
          ),
        ),
        CustomAnimationBuilder(
          control: control.value,
          tween: MovieTween()
            ..tween(
              'opacity',
              Tween<double>(begin: 0, end: 1),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            )
            ..tween(
              'position',
              Tween<Offset>(begin: const Offset(0, 70), end: Offset.zero),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            )
            ..tween(
              'scale',
              Tween<double>(begin: 1.2, end: 1),
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 500),
            ),
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 700),
          builder: (context, value, child) {
            return Opacity(
              opacity: value.get('opacity'),
              child: Transform.translate(
                offset: value.get('position'),
                child: Transform.scale(
                  scale: value.get('scale'),
                  child: child,
                ),
              ),
            );
          },
          child: GradientAnimationText(
              text: Text('Pecunia',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 64)),
              colors: const [Color(0xFF76FFF7), Color(0xFFF5FF7E), Color(0xFFF154FF)],
              duration: const Duration(seconds: 5),
              transform: const GradientRotation(math.pi / 4)),
        ),
        CustomAnimationBuilder(
            control: control.value,
            tween: MovieTween()
              ..tween(
                'opacity',
                Tween<double>(begin: 0, end: 1),
                curve: Curves.easeOutCubic,
                duration: const Duration(milliseconds: 500),
              )
              ..tween(
                'position',
                Tween<Offset>(begin: const Offset(0, 70), end: Offset.zero),
                curve: Curves.easeOutCubic,
                duration: const Duration(milliseconds: 500),
              )
              ..tween(
                'scale',
                Tween<double>(begin: 1.2, end: 1),
                curve: Curves.easeOutCubic,
                duration: const Duration(milliseconds: 500),
              ),
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 700),
            builder: (context, value, child) {
              return Opacity(
                opacity: value.get('opacity'),
                child: Transform.translate(
                  offset: value.get('position'),
                  child: Transform.scale(
                    scale: value.get('scale'),
                    child: child,
                  ),
                ),
              );
            },
            child: const VersionTag()),
      ],
    );
  }
}

class VersionTag extends HookConsumerWidget {
  const VersionTag({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageRef = ref.watch(packageInfoProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
      ),
      child: Text(
        packageRef.when(
          data: (p) => 'beta v${p.version}',
          error: (e, s) => 'Error retrieving app version',
          loading: () => '',
        ),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontFamily: 'DMMono',
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText(this.control, {super.key});

  final ValueNotifier<Control> control;

  @override
  Widget build(BuildContext context) {
    return CustomAnimationBuilder(
      control: control.value,
      tween: MovieTween()
        ..tween(
          'opacity',
          Tween<double>(begin: 0, end: 1),
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 700),
        )
        ..tween(
          'position',
          Tween<Offset>(begin: const Offset(0, 100), end: Offset.zero),
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 700),
        )
        ..tween(
          'scale',
          Tween<double>(begin: 1.2, end: 1),
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 500),
        ),
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'),
          child: Transform.translate(
            offset: value.get('position'),
            child: Transform.scale(
              scale: value.get('scale'),
              child: child,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 84, vertical: 14),
        child: Text(
          'Because your Walmart stints need control',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}

class AuthButtons extends ConsumerWidget {
  const AuthButtons(this.control, {super.key});

  final ValueNotifier<Control> control;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAnimationBuilder(
      control: control.value,
      tween: Tween<Offset>(begin: const Offset(0, 500), end: Offset.zero),
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 900),
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(34),
              topRight: Radius.circular(34),
            )),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 34, top: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('login');
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('register');
                    },
                    child: Text('Register'),
                  ),
                  const SizedBox(width: 14),
                  IconButton(
                    onPressed: () async {
                      control.value = Control.playReverse;
                      await Future<void>.delayed(const Duration(milliseconds: 2000));
                      control.value = Control.play;
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                  const SizedBox(width: 14),
                  IconButton(
                    onPressed: () async {
                      final shared = await SharedPreferences.getInstance();
                      await shared
                          .setBool(kPrefsIsFirstOpen, true)
                          .then((value) => context.goNamed('onboarding'));
                      debugPrint('is_first_open set to true');
                      // ignore: use_build_context_synchronously
                    },
                    icon: const Icon(Icons.verified_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  await ref.read(continueAsGuestProvider.notifier).continueAsGuest();
                },
                child: const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
