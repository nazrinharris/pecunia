import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_expense_txns.g.dart';

@riverpod
class GetAllExpenseTxns extends _$GetAllExpenseTxns {
  @override
  Future<List<Transaction>> build() async {
    return _getAllExpenseTxns();
  }

  Future<List<Transaction>> _getAllExpenseTxns() async {
    return (await ref.read(transactionsRepoProvider).getAllExpenseTxn().run()).fold(
      (l) => Future<List<Transaction>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
