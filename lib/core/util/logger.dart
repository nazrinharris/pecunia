import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';

import 'package:pecunia/core/errors/failures.dart';

final logger = Logger(printer: PrettyPrinter());

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      if (newValue.error is AuthFailure) {
        final failure = newValue.error as Failure;
        debugPrint(
            '(${provider.name}) : ${newValue.runtimeType} ${failure.runtimeType} - ${failure.errorType}');
        return;
      }

      if (newValue.error is Failure) {
        final failure = newValue.error as Failure;
        debugPrint('(${provider.name}) : ${failure.toVerboseString()}');
        return;
      } else {
        debugPrint('(${provider.name}) : ${newValue.error.runtimeType}');
        return;
      }
    } else if (newValue is AsyncData) {
      debugPrint('(${provider.name}) : $newValue');
    } else {
      debugPrint('(${provider.name}) : ${newValue.runtimeType}');
    }
  }
}
