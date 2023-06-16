import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // debugPrint('(${provider.name} | ${provider.runtimeType}) : $newValue');
    debugPrint('(${provider.name}) : $newValue');
  }
}
