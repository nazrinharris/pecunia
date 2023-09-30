import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_animations/simple_animations.dart';

class StartScreen extends HookWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final control = useState(Control.play);

    return Scaffold(
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
      ],
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
          'Say hello to stress-free money management',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons(this.control, {super.key});

  final ValueNotifier<Control> control;

  @override
  Widget build(BuildContext context) {
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
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(34),
              topRight: Radius.circular(34),
            )),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 34, top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                  splashFactory: InkRipple.splashFactory,
                ),
                onPressed: () {
                  context.pushNamed('login');
                },
                child: Text('Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    )),
              ),
              const SizedBox(width: 14),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                  splashFactory: InkRipple.splashFactory,
                ),
                onPressed: () {
                  context.pushNamed('register');
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              IconButton(
                onPressed: () async {
                  control.value = Control.playReverse;
                  await Future<void>.delayed(const Duration(milliseconds: 2000));
                  control.value = Control.play;
                },
                icon: const Icon(Icons.restart_alt_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
