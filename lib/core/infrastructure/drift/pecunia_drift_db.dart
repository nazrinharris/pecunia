import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData;
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pecunia/core/errors/auth_errors/auth_errors.dart';
import 'package:pecunia/core/infrastructure/drift/debug_dao.dart';
import 'package:pecunia/core/infrastructure/drift/icon_data_converter.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pecunia_drift_db.g.dart';

String kPecuniaDBKey(String uid) => 'pecunia_$uid.db';

/// [pecuniaDBProvider] depends on [authRepoProvider], specifically, it wants to read the logged in user. So
/// make sure that [authRepoProvider] is initialized before [pecuniaDBProvider] is.
@Riverpod(keepAlive: true)
class PecuniaDB extends _$PecuniaDB {
  PecuniaDriftDB? _db;

  @override
  Future<PecuniaDriftDB> build() async {
    _onDispose();
    state = const AsyncLoading();

    final user = await ref.read(authRepoProvider).getLoggedInUser().run();

    return user.fold(
      (l) => Future.error(l, l.stackTrace),
      (r) => r.fold(
        () => Future.error(
          AuthFailure.unknown(
              message: 'Attempted to open database connection without a logged in user',
              stackTrace: StackTrace.current),
          StackTrace.current,
        ),
        (user) {
          // return Future.error(
          //     UnexpectedFailure(
          //       stackTrace: StackTrace.current,
          //       message: "Something unexpected intentionally occurred, but basically we couldn't access your local database.",
          //     ),
          //     StackTrace.current);
          return _db = PecuniaDriftDB(_openConnection(user.uid));
        },
      ),
    );
  }

  void _onDispose() {
    ref.onDispose(() async {
      debugPrint('Closing database connection...');
      await _db?.close();
    });
  }
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
class PecuniaDriftDB extends _$PecuniaDriftDB {
  PecuniaDriftDB(super.e);

  @override
  int get schemaVersion => 1;

  Future<void> deleteDatabase(String uid) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, kPecuniaDBKey(uid)));

    if (dbFile.existsSync()) {
      debugPrint('Deleting database ${kPecuniaDBKey(uid)}');
      await dbFile.delete();
    } else {
      debugPrint('Database ${kPecuniaDBKey(uid)} does not exist, not deleting');
    }
  }
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
    await oldFile.copy(newFile.path).then((_) async => oldFile.delete());
  }

  if (oldFile.existsSync()) {
    debugPrint('pecunia.db exists, not doing anything');
  } else {
    debugPrint('pecunia.db does not exist, not doing anything');
  }

  if (newFile.existsSync()) {
    debugPrint('pecunia_$uid.db exists, opening...');
  } else {
    debugPrint('pecunia_$uid.db does not exist, creating...');
  }

  return newFile;
}

Future<List<String>> listDbFilePaths() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final dbFiles = dbFolder.listSync().where((file) => file.path.endsWith('.db')).toList();

  return dbFiles.map((file) => file.path).toList();
}

Option<String> getUIDFromPath(String path) {
  // Define the regex pattern to extract the UID
  final regExp = RegExp('pecunia_(.*).db');

  // Try to match the pattern in the given path
  final match = regExp.firstMatch(path);

  // If a match is found, return the UID (group 1 from the match)
  if (match != null) {
    return Some(match.group(1)!);
  } else {
    // If no match is found, return an empty string or handle accordingly
    return const None();
  }
}

Option<List<String>> getUIDsFromPaths(List<String> paths) {
  final uids = paths.map(getUIDFromPath).toList();

  final uidValues = uids.map((uid) => uid.getOrElse(() => '')).where((uid) => uid != '').toList();
  return Some(uidValues);
}
