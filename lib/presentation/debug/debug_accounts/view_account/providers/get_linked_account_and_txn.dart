import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_account_by_id.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_transaction_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_linked_account_and_txn.g.dart';

@riverpod
Future<(Account account, Transaction txn)> getLinkedAccountAndTxn(
  GetLinkedAccountAndTxnRef ref, {
  required String accountId,
  required String txnId,
  bool? debugReturnErrorAccount,
  bool? debugReturnErrorTransaction,
}) async {
  final (Account account, Transaction txn) = await (
    ref.watch(getAccountByIdProvider(accountId, debugReturnError: debugReturnErrorAccount).future),
    ref.watch(getTransactionByIdProvider(txnId, debugReturnError: debugReturnErrorTransaction).future)
  ).wait;
  return (account, txn);
}
