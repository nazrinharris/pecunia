import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_dialogs.g.dart';

@Riverpod(keepAlive: true)
PecuniaDialogs pecuniaDialogs(PecuniaDialogsRef ref) => PecuniaDialogs();

class PecuniaDialogs {
  Future<void> showFailureToast({
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
                    Expanded(
                      child: Text(
                        title ?? 'Something failed!',
                        style: TextStyle(
                          color: Colors.red[100],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (message != null || failure != null) const SizedBox(height: 4),
                if (message != null || failure != null)
                  Text(
                    message ?? failure?.message ?? '',
                    style: TextStyle(
                      color: Colors.red[100],
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

  Future<void> showSuccessToast({
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
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(
                  message ?? '',
                  textAlign: TextAlign.center,
                ),
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

  Future<void> showTextEntryConfirmationDialog({
    required BuildContext context,
    required String title,
    required String description,
    required void Function() onConfirm,
    String? entryConfirmationText,
    String? confirmButtonText,
    String? cancelButtonText,
    void Function()? onCancel,
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
              child: TextEntryConfirmationDialog(
                title: title,
                description: description,
                onConfirm: onConfirm,
                entryConfirmationText: entryConfirmationText,
                confirmButtonText: confirmButtonText,
                cancelButtonText: cancelButtonText,
                onCancel: onCancel,
              )),
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

class TextEntryConfirmationDialog extends HookConsumerWidget {
  const TextEntryConfirmationDialog({
    required this.title,
    required this.description,
    required this.onConfirm,
    this.entryConfirmationText,
    this.confirmButtonText,
    this.cancelButtonText,
    this.onCancel,
    super.key,
  });

  final String title;
  final String description;
  final String? entryConfirmationText;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTextEntryValid = useState(false);
    final textEntryController = useTextEditingController();

    return AlertDialog(
      icon: Icon(Icons.warning_amber_rounded, color: Colors.red[200], size: 48),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red[200],
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textEntryController,
              onChanged: (value) => isTextEntryValid.value = value == entryConfirmationText,
              decoration: InputDecoration(
                labelText: 'Type "$entryConfirmationText" to continue',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(cancelButtonText ?? 'Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: isTextEntryValid.value
              ? () {
                  onConfirm();
                  Navigator.of(context).pop();
                }
              : null,
          icon: Icon(
            Icons.delete_forever,
            color: isTextEntryValid.value ? Colors.red[200] : Colors.grey[500],
          ),
          label: Text(
            confirmButtonText ?? 'Confirm',
            style: TextStyle(
              color: isTextEntryValid.value ? Colors.red[200] : Colors.grey[500],
            ),
          ),
        ),
      ],
    );
  }
}

Color calculateOverlayColor(Color baseColor, double opacity) {
  final red = (0.15 * 255 + (1 - opacity) * baseColor.red).round();
  final green = (0.15 * 255 + (1 - opacity) * baseColor.green).round();
  final blue = (0.15 * 255 + (1 - opacity) * baseColor.blue).round();

  return Color.fromRGBO(red, green, blue, 1);
}
