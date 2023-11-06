import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_income_txns.g.dart';

@riverpod
class GetAllIncomeTxns extends _$GetAllIncomeTxns {
  @override
  Future<List<Transaction>> build() async {
    return _getAllIncomeTxns();
  }

  Future<List<Transaction>> _getAllIncomeTxns() async {
    return (await ref.read(transactionsRepoProvider).getAllIncomeTxn().run()).fold(
      (l) => Future<List<Transaction>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
