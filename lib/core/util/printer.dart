import 'dart:convert';

import 'package:flutter/foundation.dart';

void prettyPrintJson(Map<String, dynamic> json) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyPrint = encoder.convert(json);
  debugPrint(prettyPrint);
}

void prettyPrintMap(Map<String, dynamic> map, [int indent = 0]) {
  final padding = ' ' * indent;
  map.forEach((key, value) {
    print('$padding$key:');
    if (value is Map<String, dynamic>) {
      prettyPrintMap(value, indent + 2);
    } else if (value is List<dynamic>) {
      if (value.isEmpty) {
        print('$padding  []');
      } else if (value.first is Map<String, dynamic>) {
        value.forEach((mapValue) {
          if (mapValue is Map<String, dynamic>) {
            prettyPrintMap(mapValue, indent + 2);
          } else {
            print('$padding  $mapValue');
          }
        });
      } else {
        print('$padding  $value');
      }
    } else {
      print('$padding  $value');
    }
  });
}
