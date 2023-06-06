import 'package:equatable/equatable.dart';

base class Failure extends Equatable {
  const Failure({
    required this.stackTrace,
    this.message = 'Unexpected error occurred, please try again.',
    this.rawException,
  });

  final String message;
  final StackTrace stackTrace;
  final Object? rawException;

  @override
  List<Object> get props => [message, stackTrace];
}
