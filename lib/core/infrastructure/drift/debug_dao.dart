import 'package:drift/drift.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_dao.g.dart';

@riverpod
DebugDAO debugDAO(DebugDAORef ref) => ref.watch(pecuniaDBProvider).requireValue.debugDAO;

@DriftAccessor(
  tables: [
    AccountsTable,
    CategoriesTable,
    TransactionsTable,
    TxnCategoriesTable,
  ],
)
class DebugDAO extends DatabaseAccessor<PecuniaDriftDB> with _$DebugDAOMixin {
  DebugDAO(super.db);

  Future<void> deleteAllTxnCategoriesEntries() {
    return transaction(() async {
      await delete(txnCategoriesTable).go();
    });
  }
}
