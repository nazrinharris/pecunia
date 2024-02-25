import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

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

  MaterialColor toMaterialColor() {
    return ColorTools.createPrimarySwatch(toColor());
  }
}

extension ColorExtension on Color {
  bool useWhiteForeground() {
    // Compute the luminance of the color and determine if the color is bright or dark
    final luminance = (0.299 * red + 0.587 * green + 0.114 * blue) / 255;
    return luminance < 0.5;
  }
}

extension DateTimeExtension on DateTime {
  String get formatted {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays > 1 && difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }
    return '$month/$day/$year';
  }
}

extension TransactionExtenstion on List<Transaction> {
  List<Transaction> get sortedByMostRecent {
    return this..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
  }
}

extension MonthExtension on int {
  String get monthName {
    switch (this) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      default:
        return 'December';
    }
  }
}
