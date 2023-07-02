import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_transaction.g.dart';

@riverpod
class DeleteTransaction extends _$DeleteTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteTransaction(Transaction txn) async {
    state = const AsyncValue.loading();

    (await ref.watch(transactionsRepoProvider).deleteTransaction(txn).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}
