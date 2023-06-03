import 'package:equatable/equatable.dart';

abstract base class Failure extends Equatable {
  final String message;
  final StackTrace stackTrace;

  const Failure({
    required this.message,
    required this.stackTrace,
  });

  @override
  List<Object> get props => [message, stackTrace];
}
