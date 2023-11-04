import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_transactions.g.dart';

@riverpod
class GetAllTransactions extends _$GetAllTransactions {
  @override
  Future<List<Transaction>> build() async {
    // Watch all possible write
    watchAllWritesAsyncNotifierProvider<List<Transaction>>(ref);

    return _getAllTransactions();
  }

  Future<List<Transaction>> _getAllTransactions() async {
    return (await ref.read(transactionsRepoProvider).getAllTransactions().run()).fold(
      (l) => Future<List<Transaction>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
