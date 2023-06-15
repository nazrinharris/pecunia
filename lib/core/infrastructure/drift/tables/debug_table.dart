import 'package:drift/drift.dart';

@DataClassName('DebugEntryDTO')
class DebugTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get desc => text()();
}
