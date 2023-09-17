import 'package:flutter/foundation.dart';

//TODO: Move the explanation and rationale for the common folder to the wiki, rather than this docstring.
/// `description.dart`
///
/// This file defines a generic Description class that is used across multiple
/// features of the application. The Description class is a value object that
/// represents a description field which can be null.
///
/// The Description class is placed in the `common` directory within `core` because
/// it is shared across multiple features of the application. It is not specific to
/// any single feature and hence does not belong in the `features` directory.
///
/// The `common` directory is used for code that is shared across multiple features
/// but is not utility code. Utility code, which is placed in the `util` directory,
/// is typically lower-level and more generic, such as string formatting functions,
/// date manipulation functions, etc. The Description class, on the other hand, is
/// a higher-level construct that is directly related to the business logic of the
/// application, and hence it is placed in the `common` directory.
///
/// The Description class is used in the Account, Transaction, and Category features.
/// By defining it in a common place, we avoid code duplication and ensure consistency
/// across these features.
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
