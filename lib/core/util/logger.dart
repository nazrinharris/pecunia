import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

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
      if (newValue.error is Failure) {
        debugPrint('(${provider.name}) : ${newValue.error}');
      } else {
        debugPrint('(${provider.name}) : ${newValue.error.runtimeType}');
      }
    } else if (newValue is AsyncData) {
      debugPrint('(${provider.name}) : $newValue');
    } else {
      debugPrint('(${provider.name}) : ${newValue.runtimeType}');
    }
  }
}
