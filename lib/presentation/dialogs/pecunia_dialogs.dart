import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:full_screen_dialog_manager/full_screen_dialog_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:positioned_dialog_manager/positioned_dialog_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_dialogs.g.dart';

/// ******************************************************************************************************
/// * General Interface for Pecunia Dialogs
/// ******************************************************************************************************

@Riverpod(keepAlive: true)
PecuniaDialogs pecuniaDialogs(PecuniaDialogsRef ref) => _PecuniaDialogsImpl();

abstract interface class PecuniaDialogs {
  Future<void> showFailureDialog({
    Failure? failure,
    String? title,
    String? message,
  });
  Future<void> showSuccessDialog({
    String? title,
    String? message,
  });
  Future<void> showConfirmationDialog({
    required String title,
    required void Function() onConfirm,
    String? message,
  });
  Future<void> showInfoDialog(String message);
  Future<void> showWarningDialog(String message);
  Future<void> showLoadingDialog();
  Future<void> hideLoadingDialog();

  Future<void> showDebugPositionedDialog();
  Future<void> showDebugFullScreenDialog();
}

class _PecuniaDialogsImpl implements PecuniaDialogs {
  @override
  Future<void> showFailureDialog({
    Failure? failure,
    String? title,
    String? message,
  }) async {
    await FlutterEasyDialogs.provider.showPositioned(
      PositionedShowParams(
        content: FailureDialog(
          failure: failure,
          title: title,
          message: message,
        ),
        animator: const PositionedAnimator.verticalSlide(),
        dismissible: const PositionedDismissible.swipe(
          direction: PositionedDismissibleSwipeDirection.vertical,
        ),
        shell: const PositionedDialogShell.banner(
          backgroundColor: Colors.transparent,
        ),
        hideAfterDuration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Future<void> showSuccessDialog({
    String? title,
    String? message,
  }) async {
    await FlutterEasyDialogs.provider.showPositioned(
      PositionedShowParams(
        content: SuccessDialog(title: title, message: message),
        animator: const PositionedAnimator.verticalSlide(),
        dismissible: const PositionedDismissible.swipe(
          direction: PositionedDismissibleSwipeDirection.vertical,
        ),
        shell: const PositionedDialogShell.banner(
          backgroundColor: Colors.transparent,
        ),
        hideAfterDuration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Future<void> showConfirmationDialog({
    required String title,
    required void Function() onConfirm,
    String? message,
  }) async {
    await FlutterEasyDialogs.provider.showFullScreen(
      FullScreenShowParams(
        content: ConfirmationDialog(
          title: title,
          message: message,
          onConfirm: onConfirm,
        ),
        animationConfiguration: const EasyDialogAnimatorConfiguration(
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        ),
        backgroundAnimator: FullScreenBackgroundAnimator.fade(
          backgroundColor: Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }

  @override
  Future<void> hideLoadingDialog() async {
    // TODO: implement hideLoadingDialog
    throw UnimplementedError();
  }

  @override
  Future<void> showInfoDialog(String message) async {
    // TODO: implement showInfoDialog
    throw UnimplementedError();
  }

  @override
  Future<void> showLoadingDialog() async {
    // TODO: implement showLoadingDialog
    throw UnimplementedError();
  }

  @override
  Future<void> showWarningDialog(String message) async {
    // TODO: implement showWarningDialog
    throw UnimplementedError();
  }

  @override
  Future<void> showDebugPositionedDialog() async {
    await FlutterEasyDialogs.provider.showPositioned(
      PositionedShowParams(
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 54, 49, 49),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('This is a positioned dialog (dismiss it with vertical swipe)'),
        ),
        animator: const PositionedAnimator.verticalSlide(),
        dismissible: const PositionedDismissible.swipe(
          direction: PositionedDismissibleSwipeDirection.vertical,
        ),
        shell: const PositionedDialogShell.banner(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Future<void> showDebugFullScreenDialog() async {
    await FlutterEasyDialogs.provider.showFullScreen(
      FullScreenShowParams(
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 49, 49),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Full screen dialog doing its thing...',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CupertinoActivityIndicator(),
              ],
            ),
          ),
          animationConfiguration: const EasyDialogAnimatorConfiguration(
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 200),
          ),
          backgroundAnimator: FullScreenBackgroundAnimator.fade(
            backgroundColor: Colors.black.withOpacity(0.8),
          ),
          foregroundAnimator: const FullScreenForegroundAnimator.fade(
            curve: Curves.easeOutExpo,
          )),
    );
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

class SuccessDialog extends ConsumerWidget {
  const SuccessDialog({
    this.title = 'Everything went well!',
    this.message,
    super.key,
  });

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bg = Color.fromARGB(255, 0, 33, 1);
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
            Icon(Icons.done, color: Colors.green[100]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.green[100],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 4),
              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 4),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Text(
                  message!,
                  style: const TextStyle(
                    color: Colors.white,
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
                color: Colors.green[100]!.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConfirmationDialog extends ConsumerWidget {
  const ConfirmationDialog({
    required this.title,
    required this.onConfirm,
    super.key,
    this.message,
  });

  final String title;
  final String? message;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bg = Color.fromARGB(255, 14, 3, 43);
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(EvaIcons.question_mark_circle_outline, color: Colors.white),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Text(
                  message!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Divider(color: Colors.white.withOpacity(0.1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => FlutterEasyDialogs.provider.hideFullScreen(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(bg),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirm();
                        FlutterEasyDialogs.provider.hideFullScreen();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 37, 23, 72)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
