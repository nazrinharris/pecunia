import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pecunia/core/infrastructure/drift/debug_dao.dart';
import 'package:pecunia/core/infrastructure/drift/icon_data_converter.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_drift_db.g.dart';

@Riverpod(keepAlive: true)
Future<PecuniaDB> pecuniaDB(PecuniaDBRef ref) async {
  final user = await ref.read(authRepoProvider).getLoggedInUser().run();

  return user.fold(
    (l) => Future.error(l, l.stackTrace),
    (r) => r.fold(
      () => Future.error(
        Exception('Attempted to open database without a logged in user'),
        StackTrace.current,
      ),
      (t) => PecuniaDB(_openConnection(t.uid)),
    ),
  );
}

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

LazyDatabase _openConnection(String uid) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = await maybeMigrateDatabase(dbFolder, uid);

    debugPrint('Opening database connection for path ${dbFile.path}');

    return NativeDatabase.createBackgroundConnection(dbFile);
  });
}

Future<File> maybeMigrateDatabase(Directory dbFolder, String uid) async {
  final oldFile = File(p.join(dbFolder.path, 'pecunia.db'));
  final newFile = File(p.join(dbFolder.path, 'pecunia_$uid.db'));

  if (oldFile.existsSync() && !newFile.existsSync()) {
    debugPrint('Copying data from pecunia.db to pecunia_$uid.db');
    await oldFile.copy(newFile.path);
  }

  if (newFile.existsSync()) {
    if (oldFile.existsSync()) {
      debugPrint('pecunia.db exists, not doing anything');
    }
    debugPrint('pecunia_$uid.db exists, opening...');
  } else {
    if (oldFile.existsSync()) {
      debugPrint('pecunia.db exists, not doing anything');
    }
    debugPrint('pecunia_$uid.db does not exist, creating...');
  }

  return newFile;
}
