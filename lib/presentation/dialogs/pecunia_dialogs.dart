import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:full_screen_dialog_manager/full_screen_dialog_manager.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:positioned_dialog_manager/positioned_dialog_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_dialogs.g.dart';

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
  Future<void> showInfoDialog(String message);
  Future<void> showWarningDialog(String message);
  Future<void> showConfirmationDialog(String message);
  Future<void> showLoadingDialog();
  Future<void> hideLoadingDialog();

  Future<void> showDebugPositionedDialog();
  Future<void> showDebugFullScreenDialog();
}

class _PecuniaDialogsImpl implements PecuniaDialogs {
  @override
  Future<void> showFailureDialog({
    Failure? failure,
    String? title = 'Uh oh, something went wrong!',
    String? message,
  }) async {
    final chosenMessage = message ?? failure?.message;

    await FlutterEasyDialogs.provider.showPositioned(
      PositionedShowParams(
        content: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 61, 4, 0),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red[100]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      color: Colors.red[100],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
        content: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 33, 1),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.done, color: Colors.green[100]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      color: Colors.green[100],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              if (message != null) ...[
                const SizedBox(height: 4),
                Divider(color: Colors.white.withOpacity(0.1)),
                const SizedBox(height: 4),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: Text(
                    message,
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
  Future<void> hideLoadingDialog() async {
    // TODO: implement hideLoadingDialog
    throw UnimplementedError();
  }

  @override
  Future<void> showConfirmationDialog(String message) async {
    // TODO: implement showConfirmationDialog
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
        backgroundAnimator: FullScreenBackgroundAnimator.blur(
          backgroundColor: Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }
}
