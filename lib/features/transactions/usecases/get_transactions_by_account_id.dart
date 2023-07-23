import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transactions_by_account_id.g.dart';

@riverpod
Future<List<Transaction>> getTransactionsByAccountId(
  GetTransactionsByAccountIdRef ref,
  String accountId,
) async {
  return (await ref.read(transactionsRepoProvider).getTransactionsByAccount(accountId).run()).fold(
    (l) => Future<List<Transaction>>.error(l, l.stackTrace),
    (r) => r,
  );
}
