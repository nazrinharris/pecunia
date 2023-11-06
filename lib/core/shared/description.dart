import 'package:flutter/foundation.dart';

//TODO: Move the explanation and rationale for the common folder to the wiki, rather than this docstring.
/// `description.dart`
///
/// The Description class is a value object that
/// represents a description field which can be null.
///
/// Usage:
/// ```dart
/// Description description = Description('This is a description');
/// print(description.value); // Outputs: 'This is a description'
/// ```
@immutable
class Description {
  Description(String? input) : value = _validateInput(input);

  final String? value;

  @override
  String toString() => value ?? 'No Description';

  static String? _validateInput(String? input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }
    return input;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Description && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
