import 'package:drift/drift.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_dao_tables.g.dart';

@riverpod
AccountsDAO accountsDAO(AccountsDAORef ref) => ref.watch(pecuniaDBProvider).accountsDAO;

@DataClassName('AccountDTO')
class AccountsTable extends Table {
  TextColumn get id => text()();
  TextColumn get creatorUid => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  RealColumn get initialBalance => real()();
  RealColumn get balance => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3)();
  DateTimeColumn get createdOn => dateTime()();
  TextColumn get description => text().withLength(min: 0, max: 500).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [
  AccountsTable,
])
class AccountsDAO extends DatabaseAccessor<PecuniaDB> with _$AccountsDAOMixin {
  AccountsDAO(super.db);

  Future<List<AccountDTO>> getAllAccounts() async {
    return select(accountsTable).get();
  }

  Stream<List<AccountDTO>> watchAllAccounts() {
    return select(accountsTable).watch();
  }

  Future<void> insertAccount(AccountDTO account) async {
    await into(accountsTable).insert(account);
  }

  Future<void> updateAccount(AccountDTO account) async {
    await update(accountsTable).replace(account);
  }

  Future<void> deleteAccount(AccountDTO account) async {
    await (delete(accountsTable)..where((tbl) => tbl.id.equals(account.id))).go();
  }
}
