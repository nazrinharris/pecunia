import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart' as all_material;

class IconDataConverter extends TypeConverter<IconData, String> {
  const IconDataConverter();

  @override
  IconData fromSql(String fromDb) {
    final iconMap = json.decode(fromDb) as Map<String, dynamic>;
    // final pack = iconMap['pack']; // Uncomment this if ever used other than all_material, but adjustments will need to be made.
    final iconKey = iconMap['key'];

    return all_material.allIcons[iconKey]?.data ?? Icons.question_mark;
  }

  @override
  String toSql(IconData value) {
    return json.encode({
      'pack': 'allMaterial',
      'key': _getIconKey(all_material.allIcons, value),
    });
  }
}

String _getIconKey(Map<String, IconPickerIcon> icons, IconData icon) =>
    icons.entries.firstWhere((iconEntry) => iconEntry.value.data == icon).key;
