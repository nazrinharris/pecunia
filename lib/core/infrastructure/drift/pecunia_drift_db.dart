import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'pecunia_drift_db.g.dart';

@DriftDatabase()
class PecuniaDB extends _$PecuniaDB {
  PecuniaDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pecunia.db'));
    return NativeDatabase.createBackgroundConnection(file);
  });
}
