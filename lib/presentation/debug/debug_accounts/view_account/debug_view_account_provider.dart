import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_view_account_provider.g.dart';

@riverpod
class GetTransactionsByAccountId extends _$GetTransactionsByAccountId {
  @override
  FutureOr<List<Transaction>> build() {
    return [];
  }

  Future<void> getAllTransactions(String accountId) async {
    state = const AsyncValue.loading();

    (await ref.read(transactionsRepoProvider).getTrasactionsByAccount(accountId).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(r),
    );
  }
}
