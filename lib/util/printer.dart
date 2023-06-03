import 'dart:convert';

import 'package:flutter/foundation.dart';

void prettyPrintJson(Map<String, dynamic> json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyPrint = encoder.convert(json);
  debugPrint(prettyPrint);
}
