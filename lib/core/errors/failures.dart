import 'package:equatable/equatable.dart';

class Failure extends Equatable {
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
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.stackTrace,
    super.message,
    super.rawException,
  });
}
