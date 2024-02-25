import 'package:money2/money2.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_txns_current_month.g.dart';

@riverpod
Future<List<Transaction>> getTxnsCurrentMonth(
  GetTxnsCurrentMonthRef ref, {
  required TransactionType type,
  required Currency currency,
}) async {
  watchAllWritesFutureProvider<List<Transaction>>(ref);

  return (await ref.read(transactionsRepoProvider).getTxnsCurrentMonth(type: type, currency: currency).run())
      .fold(
    (f) => Future<List<Transaction>>.error(f, f.stackTrace),
    (r) => r,
  );
}
