import 'package:equatable/equatable.dart';

abstract base class BaseException extends Equatable implements Exception {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;

  const BaseException({
    required this.message,
    this.errorCode,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, errorCode, stackTrace];
}
