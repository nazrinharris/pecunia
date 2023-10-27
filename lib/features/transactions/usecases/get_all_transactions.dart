import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/create_transaction.dart';
import 'package:pecunia/features/transactions/usecases/create_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transaction.dart';
import 'package:pecunia/features/transactions/usecases/delete_transfer_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transaction.dart';
import 'package:pecunia/features/transactions/usecases/edit_transfer_transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_transactions.g.dart';

@riverpod
class GetAllTransactions extends _$GetAllTransactions {
  @override
  Future<List<Transaction>> build() async {
    // Watch all possible write
    ref
      ..watch(createAccountProvider)
      ..watch(deleteAccountProvider)
      ..watch(editAccountProvider)
      ..watch(createTransactionProvider)
      ..watch(deleteTransactionProvider)
      ..watch(editTransactionProvider)
      ..watch(createTransferTransactionProvider)
      ..watch(deleteTransferTransactionProvider)
      ..watch(editTransferTransactionProvider);

    return _getAllTransactions();
  }

  Future<List<Transaction>> _getAllTransactions() async {
    return (await ref.read(transactionsRepoProvider).getAllTransactions().run()).fold(
      (l) => Future<List<Transaction>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
