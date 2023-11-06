import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show IconData;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pecunia/core/infrastructure/drift/debug_dao.dart';
import 'package:pecunia/core/infrastructure/drift/icon_data_converter.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_drift_db.g.dart';

@Riverpod(keepAlive: true)
PecuniaDB pecuniaDB(PecuniaDBRef ref) => PecuniaDB(_openConnection());

@DriftDatabase(
  tables: [
    AccountsTable,
    TransactionsTable,
    CategoriesTable,

    // Join Tables
    TxnCategoriesTable,
  ],
  daos: [
    AccountsLocalDAO,
    TransactionsLocalDAO,
    CategoriesLocalDAO,
    TxnCategoriesLocalDAO,
    DebugDAO,
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
