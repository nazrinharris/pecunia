import 'package:money2/money2.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_txns_over_period.g.dart';

@riverpod
Future<List<Transaction>> getTxnsOverPeriod(
  GetTxnsOverPeriodRef ref, {
  required DateTime startDate,
  required DateTime endDate,
  required TransactionType type,
  required Currency currency,
  bool includeTransfers = false,
}) async {
  watchAllWritesFutureProvider<List<Transaction>>(ref);

  return (await ref
          .read(transactionsRepoProvider)
          .getTxnsOverPeriod(
              startDate: startDate,
              endDate: endDate,
              type: type,
              currency: currency,
              includeTransfers: includeTransfers)
          .run())
      .fold(
    (l) => Future<List<Transaction>>.error(l, l.stackTrace),
    (r) => r,
  );
}
