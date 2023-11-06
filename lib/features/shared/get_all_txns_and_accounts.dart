import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/usecases/get_all_transactions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_txns_and_accounts.g.dart';

@riverpod
Future<(List<Transaction> txns, List<Account> accounts)> getAllTxnsAndAccounts(
  GetAllTxnsAndAccountsRef ref,
) async {
  final (List<Transaction> txns, List<Account> accounts) = await (
    ref.watch(getAllTransactionsProvider.future),
    ref.watch(getAllAccountsProvider.future),
  ).wait;

  return (txns, accounts);
}
