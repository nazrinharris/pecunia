import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transfer_transaction.g.dart';

@riverpod
class CreateTransferTransaction extends _$CreateTransferTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> createTransferTransaction({
    required Account sourceAccount,
    required Account destinationAccount,
    required double sourceTransactionAmount,
    required double? destinationTransactionAmount,
    required double? exchangeRate,
    required String transferDescription,
  }) async {
    state = const AsyncLoading();

    debugPrint('retrieving logged in user...');
    final failureOrPecuniaUser = await ref.read(authRepoProvider).getLoggedInUser().run();

    final pecuniaUser = failureOrPecuniaUser.fold(
      (failure) {
        state = AsyncValue.error(failure, failure.stackTrace);
      },
      (pecuniaUser) => pecuniaUser,
    );

    if (pecuniaUser != null) {
      debugPrint('user exists, creating transaction...');
      (await ref
              .read(transactionsRepoProvider)
              .createTransferTransaction(
                sourceAccount: sourceAccount,
                destinationAccount: destinationAccount,
                sourceTransactionAmount: sourceTransactionAmount,
                destinationTransactionAmount: destinationTransactionAmount,
                exchangeRate: exchangeRate,
                transferDescription: transferDescription,
              )
              .run())
          .fold(
        (l) => state = AsyncError(l, l.stackTrace),
        (r) => state = AsyncData(Option.of(r)),
      );
    }
  }
}
