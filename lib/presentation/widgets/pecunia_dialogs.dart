import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_dialogs.g.dart';

@Riverpod(keepAlive: true)
PecuniaDialogs pecuniaDialogs(PecuniaDialogsRef ref) => PecuniaDialogs();

class PecuniaDialogs {
  Future<void> showFailureDialog({
    required BuildContext context,
    Failure? failure,
    String? title,
    String? message,
  }) async {
    final toastKey = GlobalKey<ToastState>();

    final entry = showPersistentToast(
      context: context,
      toast: Toast(
        key: toastKey,
        alignment: Alignment.topRight,
        animationBuilder: (context, animation, child) => SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        ),
        child: Dismissible(
          key: const Key('dismissable'),
          direction: DismissDirection.startToEnd,
          child: Container(
            margin: const EdgeInsets.only(top: 60, left: 64),
            padding: const EdgeInsets.only(top: 14, bottom: 14, left: 24, right: 16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 61, 4, 0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_outlined, color: Colors.red[100]),
                    const SizedBox(width: 10),
                    Text(
                      title ?? 'Something failed!',
                      style: TextStyle(
                        color: Colors.red[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (message != null) const SizedBox(height: 4),
                if (message != null)
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.green[100],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 4), () async {
      await toastKey.currentState?.dismissToastAnim();
      ToastManager.dismiss(entry);
    });
  }

  Future<void> showSuccessDialog({
    required BuildContext context,
    String? title,
    String? message,
  }) async {
    final toastKey = GlobalKey<ToastState>();

    final entry = showPersistentToast(
      context: context,
      toast: Toast(
        key: toastKey,
        alignment: Alignment.topRight,
        animationBuilder: (context, animation, child) => SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        ),
        child: Dismissible(
          key: const Key('dismissable'),
          direction: DismissDirection.startToEnd,
          child: Container(
            margin: const EdgeInsets.only(top: 60, left: 64),
            padding: const EdgeInsets.only(top: 14, bottom: 14, left: 24, right: 16),
            decoration: const BoxDecoration(
              color: Color(0xff233921),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline_rounded, color: Colors.green[100]),
                    const SizedBox(width: 10),
                    Text(
                      title ?? 'Something succeeded!',
                      style: TextStyle(
                        color: Colors.green[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (message != null) const SizedBox(height: 4),
                if (message != null)
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.green[100],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 4), () async {
      await toastKey.currentState?.dismissToastAnim();
      ToastManager.dismiss(entry);
    });
  }

  Future<void> showConfirmationDialog({
    required String title,
    required void Function() onConfirm,
    required BuildContext context,
    Icon? icon,
    String? message,
  }) async {
    await showGeneralDialog<void>(
      context: context,
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: a1,
            curve: Curves.easeOutCubic,
          ),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: a1,
              curve: Curves.easeOutCubic,
            ),
            child: AlertDialog(
              icon: Icon(Icons.warning_amber_rounded, color: Colors.red[200], size: 48),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[200],
                ),
              ),
              content: Text(
                message ?? '',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  icon: icon ?? Icon(Icons.delete_forever, color: Colors.red[200]),
                  label: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.red[200]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showDebugPositionedDialog(BuildContext context) async {
    final toastKey = GlobalKey<ToastState>();

    final entry = showPersistentToast(
      context: context,
      toast: Toast(
        key: toastKey,
        alignment: Alignment.topRight,
        animationBuilder: (context, animation, child) => SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        ),
        child: Dismissible(
          key: const Key('dismissable'),
          direction: DismissDirection.startToEnd,
          child: Container(
            margin: const EdgeInsets.only(top: 60, left: 64),
            padding: const EdgeInsets.only(top: 14, bottom: 14, left: 24, right: 16),
            decoration: const BoxDecoration(
              color: Color(0xff233921),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline_rounded, color: Colors.green[100]),
                    const SizedBox(width: 10),
                    Text(
                      'Account Created!',
                      style: TextStyle(
                        color: Colors.green[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'It seems that your account was created succesfully!',
                  style: TextStyle(
                    color: Colors.green[100],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 4), () async {
      await toastKey.currentState?.dismissToastAnim();
      ToastManager.dismiss(entry);
    });
  }
}

/// ******************************************************************************************************
/// * UI Components for Pecunia Dialogs
/// ******************************************************************************************************

class FailureDialog extends ConsumerWidget {
  const FailureDialog({
    this.failure,
    this.title,
    this.message,
    super.key,
  });

  final Failure? failure;
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenMessage = message ?? failure?.message;
    const bg = Color.fromARGB(255, 61, 4, 0);
    final overlayColor = calculateOverlayColor(bg, 0.15);

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            overlayColor,
            bg,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red[100]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                title ?? 'Uh oh, something went wrong!',
                style: TextStyle(
                  color: Colors.red[100],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (chosenMessage != null) ...[
              const SizedBox(height: 4),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 4),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Text(
                  chosenMessage,
                  style: TextStyle(
                    color: Colors.red[100],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.red[100]!.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color calculateOverlayColor(Color baseColor, double opacity) {
  final red = (0.15 * 255 + (1 - opacity) * baseColor.red).round();
  final green = (0.15 * 255 + (1 - opacity) * baseColor.green).round();
  final blue = (0.15 * 255 + (1 - opacity) * baseColor.blue).round();

  return Color.fromRGBO(red, green, blue, 1);
}
