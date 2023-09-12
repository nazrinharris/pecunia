import 'package:flutter/material.dart';

extension NumericExtension on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
}

extension TruncateExtension on String {
  String truncate() {
    const maxLength = 200;

    if (length <= maxLength) {
      return this;
    }

    return '${substring(0, maxLength)}...';
  }
}

// TODO: Maybe make a whole "feature" for this?
// TODO: Error handling?
extension StringColorExtension on String {
  Color toColor() {
    return Color(int.parse(this, radix: 16));
  }
}

extension ColorExtension on Color {
  bool useWhiteForeground() {
    // Compute the luminance of the color and determine if the color is bright or dark
    final luminance = (0.299 * red + 0.587 * green + 0.114 * blue) / 255;
    return luminance < 0.5;
  }
}
