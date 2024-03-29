import 'package:flutter/foundation.dart' as f;
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction.g.dart';

@riverpod
class CreateTransaction extends _$CreateTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> createTransaction({
    required String name,
    required String? description,
    required String accountId,
    required TransactionType transactionType,
    required double baseAmount,
    required String baseCurrency,
    required double? exchangeRate,
    required String? targetCurrency,
    required double? targetAmount,
    required Category? category,
  }) async {
    state = const AsyncValue.loading();

    f.debugPrint('retrieving logged in user...');
    final failureOrPecuniaUser = await ref.read(authRepoProvider).getLoggedInUser().run();

    final pecuniaUser = failureOrPecuniaUser.fold(
      (failure) {
        state = AsyncValue.error(failure, failure.stackTrace);
        return;
      },
      (pecuniaUser) => pecuniaUser,
    );

    if (pecuniaUser != null && pecuniaUser.isSome()) {
      f.debugPrint('user exists, creating transaction...');
      (await ref
              .read(transactionsRepoProvider)
              .createTransaction(
                name: name,
                // TODO: Make better exception
                creatorUid: pecuniaUser.getOrElse(() => throw Exception()).uid,
                transactionDate: DateTime.now(),
                accountId: accountId,
                type: transactionType.typeAsString,
                baseAmount: baseAmount,
                baseCurrency: baseCurrency,
                transactionDescription: description,
                exchangeRate: exchangeRate,
                targetCurrency: targetCurrency,
                targetAmount: targetAmount,
                category: category,
              )
              .run())
          .fold(
        (l) => state = AsyncError(l, l.stackTrace),
        (r) => state = AsyncData(Option.of(r)),
      );
    }
  }
}
