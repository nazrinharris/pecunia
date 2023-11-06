import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/txn_categories_errors/txn_categories_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'txn_categories_local_dao.g.dart';

@riverpod
TxnCategoriesLocalDAO txnCategoriesLocalDAO(TxnCategoriesLocalDAORef ref) =>
    ref.watch(pecuniaDBProvider).txnCategoriesLocalDAO;

@DataClassName('TransactionCategoryDTO')
class TxnCategoriesTable extends Table {
  TextColumn get transactionId => text().references(TransactionsTable, #id)();
  TextColumn get categoryId => text().references(CategoriesTable, #id)();

  @override
  Set<Column> get primaryKey => {transactionId, categoryId};
}

@DriftAccessor(tables: [
  TxnCategoriesTable,
  TransactionsTable,
  CategoriesTable,
])
class TxnCategoriesLocalDAO extends DatabaseAccessor<PecuniaDB> with _$TxnCategoriesLocalDAOMixin {
  TxnCategoriesLocalDAO(super.db);

  TaskEither<TxnCategoriesFailure, Unit> addCategoryToTxn(String transactionId, String categoryId) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await into(txnCategoriesTable).insert(
          TransactionCategoryDTO(
            transactionId: transactionId,
            categoryId: categoryId,
          ),
        );
        return unit;
      }),
      mapDriftToTxnCategoriesFailure,
    );
  }

  TaskEither<TxnCategoriesFailure, Unit> removeCategoryFromTxn(String transactionId, String categoryId) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await (delete(txnCategoriesTable)
              ..where((txnCategory) => txnCategory.transactionId.equals(transactionId))
              ..where((txnCategory) => txnCategory.categoryId.equals(categoryId)))
            .go();
        return unit;
      }),
      mapDriftToTxnCategoriesFailure,
    );
  }

  TaskEither<TxnCategoriesFailure, List<Category>> getCategoriesByTxnId(String txnId) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        final query = select(txnCategoriesTable).join([
          innerJoin(transactionsTable, transactionsTable.id.equalsExp(txnCategoriesTable.transactionId)),
          innerJoin(categoriesTable, categoriesTable.id.equalsExp(txnCategoriesTable.categoryId)),
        ])
          ..where(transactionsTable.id.equals(txnId));

        final results = await query.get();

        return results.map((result) => Category.fromDTO(result.readTable(categoriesTable))).toList();
      }),
      mapDriftToTxnCategoriesFailure,
    );
  }

  TaskEither<TxnCategoriesFailure, Unit> deleteCategoriesByTxnId(String txnId) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await (delete(txnCategoriesTable)..where((txnCategory) => txnCategory.transactionId.equals(txnId)))
            .go();
        return unit;
      }),
      mapDriftToTxnCategoriesFailure,
    );
  }
}
