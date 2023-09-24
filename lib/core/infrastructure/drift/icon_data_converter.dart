import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconDataConverter extends TypeConverter<IconData, String> {
  const IconDataConverter();

  @override
  IconData fromSql(String fromDb) {
    return deserializeIcon(json.decode(fromDb) as Map<String, dynamic>) ?? Icons.question_mark;
  }

  @override
  String toSql(IconData value) {
    return json.encode(serializeIcon(value));
  }
}
