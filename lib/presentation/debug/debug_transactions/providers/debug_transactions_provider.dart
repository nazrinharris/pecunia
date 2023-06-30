import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_transactions_provider.g.dart';

@riverpod
class CreateTransaction extends _$CreateTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> createTransaction({
    required String name,
    required String? description,
    required double amount,
    required String currency,
    required String accountId,
    required String type,
  }) async {
    state = const AsyncValue.loading();

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
              .createTransaction(
                name: name,
                creatorUid: pecuniaUser.uid,
                transactionDate: DateTime.now(),
                accountId: accountId,
                type: type,
                originalAmount: amount,
                originalCurrency: currency,
                transactionDescription: description,
              )
              .run())
          .fold(
        (l) => state = AsyncError(l, l.stackTrace),
        (r) {
          ref.read(getAllTransactionsProvider.notifier).getAllTransactions();
          state = AsyncData(Option.of(r));
        },
      );
    }
  }
}

@riverpod
class ChosenAccount extends _$ChosenAccount {
  @override
  Option<Account> build() {
    return const Option.none();
  }

  void updateChosenAccount(List<Account> accountsList, String chosenAccountId) {
    final chosenAccount = accountsList.firstWhere((account) => account.id == chosenAccountId);
    state = Option.of(chosenAccount);
  }
}

@riverpod
class GetAllAccounts extends _$GetAllAccounts {
  @override
  FutureOr<List<Account>> build() {
    return [];
  }

  Future<void> getAllAccounts() async {
    state = const AsyncValue.loading();

    debugPrint('retrieving logged in user...');
    final failureOrPecuniaUser = await ref.read(authRepoProvider).getLoggedInUser().run();

    final pecuniaUser = failureOrPecuniaUser.fold(
      (failure) {
        state = AsyncValue.error(failure, failure.stackTrace);
      },
      (pecuniaUser) => pecuniaUser,
    );

    if (pecuniaUser != null) {
      debugPrint('user exists, retrieving accounts...');
      (await ref.read(accountsRepoProvider).getAccounts().run()).fold(
        (l) => state = AsyncError(l, l.stackTrace),
        (r) => state = AsyncData(r),
      );
    }
  }
}

@riverpod
class GetAllTransactions extends _$GetAllTransactions {
  @override
  FutureOr<List<Transaction>> build() {
    return [];
  }

  Future<void> getAllTransactions() async {
    state = const AsyncValue.loading();

    (await ref.read(transactionsRepoProvider).getAllTransactions().run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(r),
    );
  }
}
