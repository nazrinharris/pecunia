import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_view_account_provider.g.dart';

@riverpod
Future<Account> getAccountById(GetAccountByIdRef ref, String accountId) async {
  return (await ref.read(accountsRepoProvider).getAccountById(accountId).run()).fold(
    (l) => Future<Account>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
Future<(bool isValid, double actualBalance)> validateAccountBalance(
    ValidateAccountBalanceRef ref, Account account) async {
  return (await ref.read(accountsRepoProvider).validateAccountBalance(account).run()).fold(
    (l) => Future<(bool isValid, double actualBalance)>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
Future<List<Transaction>> getTransactionsByAccountId(
  GetTransactionsByAccountIdRef ref,
  String accountId,
) async {
  return (await ref.read(transactionsRepoProvider).getTrasactionsByAccount(accountId).run()).fold(
    (l) => Future<List<Transaction>>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
class EditTransaction extends _$EditTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editTransaction({
    required Transaction oldTxn,
    required String txnName,
    required String? txnDescription,
    required String txnType,
    //  required String txnAccount, Commented out, because as of now, can't change account of a transaction
    required double txnAmount,
  }) async {
    state = const AsyncLoading();
    final newTxn = oldTxn.copyWith(
      name: txnName,
      transactionDescription: TransactionDescription(txnDescription),
      type: TransactionType.fromString(txnType, TransactionsAction.edit),
      fundDetails: oldTxn.fundDetails.copyWith(originalAmount: txnAmount),
    );

    (await ref.read(transactionsRepoProvider).updateTransaction(newTxn: newTxn, oldTxn: oldTxn).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) {
        ref.invalidate(getTransactionsByAccountIdProvider(oldTxn.accountId));
        state = AsyncData(Option.of(r));
      },
    );
  }
}
