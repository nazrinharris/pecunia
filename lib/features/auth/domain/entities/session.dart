import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session({required this.isValid});

  final bool isValid;

  Session copyWith({
    bool? isValid,
  }) {
    return Session(
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [isValid];
}
