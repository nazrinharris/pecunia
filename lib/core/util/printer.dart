import 'dart:convert';

import 'package:flutter/foundation.dart';

void prettyPrintJson(Map<String, dynamic> json) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyPrint = encoder.convert(json);
  debugPrint(prettyPrint);
}
