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
