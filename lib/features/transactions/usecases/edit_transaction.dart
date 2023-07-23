import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/features/transactions/usecases/get_transactions_by_account_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_transaction.g.dart';

@riverpod
class EditTransaction extends _$EditTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editTransaction({
    required String name,
    required String? description,
    required TransactionType transactionType,
    required double baseAmount,
    required String baseCurrency,
    required double? exchangeRate,
    required String? targetCurrency,
    required double? targetAmount,
    required Transaction oldTxn,
    //  required String txnAccount, Commented out, because as of now, can't change account of a transaction
  }) async {
    state = const AsyncLoading();
    final newTxn = oldTxn.copyWith(
        name: name,
        transactionDescription: TransactionDescription(description),
        fundDetails: oldTxn.fundDetails.copyWith(
          transactionType: transactionType,
          baseAmount: baseAmount,
          baseCurrency: baseCurrency,
          exchangeRate: exchangeRate,
          targetAmount: targetAmount,
          targetCurrency: targetCurrency,
        ));

    (await ref.read(transactionsRepoProvider).editTransaction(newTxn: newTxn, oldTxn: oldTxn).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) {
        ref.invalidate(getTransactionsByAccountIdProvider(oldTxn.accountId));
        state = AsyncData(Option.of(r));
      },
    );
  }
}
