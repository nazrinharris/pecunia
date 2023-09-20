import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transaction_by_id.g.dart';

@riverpod
Future<Transaction> getTransactionById(
  GetTransactionByIdRef ref,
  String txnId, {
  bool? debugReturnError,
}) async {
  if (debugReturnError != null && debugReturnError) {
    await Future<void>.delayed(const Duration(seconds: 2));

    return Future<Transaction>.error(TransactionsFailure.unknown(
      stackTrace: StackTrace.current,
      message: 'Transaction retrieval failed',
    ));
  }

  return (await ref.read(transactionsRepoProvider).getTransactionById(txnId).run()).fold(
    (l) => Future<Transaction>.error(l, l.stackTrace),
    (r) => r,
  );
}
