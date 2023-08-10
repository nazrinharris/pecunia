extension NumericExtension on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
}
