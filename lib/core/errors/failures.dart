import 'package:equatable/equatable.dart';

base class Failure extends Equatable {
  final String message;
  final StackTrace stackTrace;
  final Object? rawException;

  const Failure({
    required this.stackTrace,
    this.message = "Unexpected error occurred, please try again.",
    this.rawException,
  });

  @override
  List<Object> get props => [message, stackTrace];
}
