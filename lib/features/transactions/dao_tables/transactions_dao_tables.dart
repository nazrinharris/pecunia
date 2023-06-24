import 'package:drift/drift.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_dao_tables.g.dart';

@riverpod
TransactionsDAO transactionsDAO(TransactionsDAORef ref) => ref.watch(pecuniaDBProvider).transactionsDAO;

@DataClassName('TransactionDTO')
class TransactionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get creatorUid => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 500).nullable()();
  DateTimeColumn get transactionDate => dateTime()();

  TextColumn get accountId => text().references(AccountsTable, #id)();
  TextColumn get transactionType => text()();

  RealColumn get originalAmount => real()();
  TextColumn get originalCurrency => text().withLength(min: 3, max: 3)();

  RealColumn get exchangeRate => real().nullable()();
  RealColumn get exchangedToAmount => real().nullable()();
  TextColumn get exchangedToCurrency => text().withLength(min: 3, max: 3).nullable()();

  /// The id of the transaction that this transaction is a transfer of.
  TextColumn get transferLinkId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [
  TransactionsTable,
  AccountsTable,
])
class TransactionsDAO extends DatabaseAccessor<PecuniaDB> with _$TransactionsDAOMixin {
  TransactionsDAO(super.db);

  Future<void> createTransaction(TransactionDTO transaction) async {
    await into(transactionsTable).insert(transaction.toCompanion(false));
  }
}
