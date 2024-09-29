import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';

import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/util/extensions.dart';

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
        // debugPrint(
        //     '(${provider.name}) : ${newValue.runtimeType} ${failure.runtimeType} - ${failure.errorType}');
        debugPrint(failure.toVerboseString());
        return;
      }

      if (newValue.error is TransactionsFailure) {
        final failure = newValue.error as TransactionsFailure;
        debugPrint('(${provider.name}) : ${failure.errorType} - ${failure.toVerboseString()}');
        return;
      } else if (newValue.error is Failure) {
        final failure = newValue.error as Failure;
        debugPrint('(${provider.name}) : $failure');
        return;
      } else {
        debugPrint('(${provider.name}) : ${newValue.error.runtimeType} : ${newValue.error}');
        return;
      }
    } else if (newValue is AsyncData) {
      // debugPrint('(${provider.name}) : ${newValue.toString().truncate()}...');
      debugPrint('(${provider.name}) : $newValue');
    } else {
      debugPrint('(${provider.name}) : ${newValue.runtimeType}');
    }
  }
}

void prettyPrintJson(Map<String, dynamic> json) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyPrint = encoder.convert(json);
  debugPrint(prettyPrint);
}
