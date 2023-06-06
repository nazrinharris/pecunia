import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session({required this.isValid});

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}
