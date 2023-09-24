import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/common/description.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_transaction.g.dart';

@riverpod
class EditTransaction extends _$EditTransaction {
  @override
  Future<Option<TransactionId>> build() async {
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
    required ({Category? old, Category? current}) category,
    //  required String txnAccount, Commented out, because as of now, can't change account of a transaction
  }) async {
    state = const AsyncLoading();

    final newTxn = oldTxn.copyWith(
        name: name,
        transactionDescription: Description(description),
        fundDetails: oldTxn.fundDetails.copyWith(
          transactionType: transactionType,
          baseAmount: baseAmount,
          baseCurrency: PecuniaCurrencies.fromString(baseCurrency),
          exchangeRate: exchangeRate,
          targetAmount: targetAmount,
          targetCurrency: targetCurrency == null ? null : PecuniaCurrencies.fromString(targetCurrency),
        ));

    (await ref
            .read(transactionsRepoProvider)
            .editTransaction(
              newTxn: newTxn,
              oldTxn: oldTxn,
              category: category,
            )
            .run())
        .fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(oldTxn.id)),
    );
  }
}
