import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stack_trace/stack_trace.dart';

part 'failures.freezed.dart';

abstract interface class Failure extends Equatable {
  const Failure({
    required this.stackTrace,
    this.message = 'Unexpected error occurred, please try again.',
    this.rawException,
    this.errorType,
  });

  final String message;
  final StackTrace stackTrace;
  final Object? errorType;
  final Object? rawException;

  @override
  List<Object> get props => [
        message,
        stackTrace,
        rawException ?? 'No raw exception',
      ];

  @override
  String toString() {
    final stack = Trace.from(stackTrace).terse;
    return '$runtimeType: $message \n$stack';
  }

  String toVerboseString() {
    return '$runtimeType: $message \n$stackTrace \nRawException: $rawException';
  }
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.stackTrace,
    super.message,
    super.rawException,
  });
}

@freezed
class CriticalException with _$CriticalException implements Exception {
  factory CriticalException({
    required StackTrace stackTrace,
    @Default('This operation should never fail') String? message,
  }) = _CriticalException;
}
