import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/transactions/dao_tables/transactions_dao_tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_drift_db.g.dart';

@Riverpod(keepAlive: true)
PecuniaDB pecuniaDB(PecuniaDBRef ref) => PecuniaDB(_openConnection());

@DriftDatabase(
  tables: [
    AccountsTable,
    TransactionsTable,
  ],
  daos: [
    AccountsDAO,
    TransactionsDAO,
  ],
)
class PecuniaDB extends _$PecuniaDB {
  PecuniaDB(super.e);

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
