import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_transfer_transaction.g.dart';

@riverpod
class DeleteTransferTransaction extends _$DeleteTransferTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteTransaction(Transaction transferTxnToDelete) async {
    state = const AsyncValue.loading();

    (await ref.watch(transactionsRepoProvider).deleteTransferTransaction(transferTxnToDelete).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}
