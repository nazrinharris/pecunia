import 'package:pecunia/core/errors/txn_categories_errors/txn_categories_errors.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_categories_by_txn_id.g.dart';

@riverpod
Future<List<Category>> getCategoriesByTxnId(
  GetCategoriesByTxnIdRef ref,
  String txnId, {
  bool? debugReturnError,
}) async {
  if (debugReturnError != null && debugReturnError) {
    await Future<void>.delayed(const Duration(seconds: 2));

    return Future<List<Category>>.error(TxnCategoriesFailure.unknown(
      stackTrace: StackTrace.current,
      message: 'Categories of Transaction retrieval failed',
    ));
  }

  watchAllWritesFutureProvider<List<Category>>(ref);

  return (await ref.read(transactionsRepoProvider).getCategoriesByTxnId(txnId).run()).fold(
    (l) => Future<List<Category>>.error(l, l.stackTrace),
    (r) => r,
  );
}
