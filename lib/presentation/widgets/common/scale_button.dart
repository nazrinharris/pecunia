import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_animations/simple_animations.dart';

class ScaleButton extends HookConsumerWidget {
  const ScaleButton({
    required this.child,
    required this.onTap,
    super.key,
  });

  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = useState(Control.stop);

    return CustomAnimationBuilder(
      control: control.value,
      tween: MovieTween()
        ..tween(
          'scale',
          Tween<double>(begin: 1, end: 0.95),
          duration: const Duration(milliseconds: 100),
        )
        ..tween(
          'opacity',
          Tween<double>(begin: 1, end: 0.8),
          duration: const Duration(milliseconds: 100),
        ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Transform.scale(
        scale: value.get('scale'),
        child: Opacity(
          opacity: value.get('opacity'),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTapDown: (details) {
          control.value = Control.play;
        },
        onTapUp: (details) async {
          await HapticFeedback.lightImpact();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.playReverse;
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.stop;

          onTap?.call();
        },
        child: child,
      ),
    );
  }
}
