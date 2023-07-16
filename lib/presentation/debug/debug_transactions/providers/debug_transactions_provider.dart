import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
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
    required String accountId,
    required String transactionType,
    required double? baseAmount,
    required String baseCurrency,
    required double? exchangeRate,
    required String? targetCurrency,
    required double? targetAmount,
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

    double actualBaseAmount;

    // ! Temporary Workaround. Remove this when we have a proper way to handle this.
    if (baseAmount == null) {
      actualBaseAmount = targetAmount! / exchangeRate!;
    } else {
      actualBaseAmount = baseAmount;
    }

    if (pecuniaUser != null) {
      debugPrint('user exists, creating transaction...');
      // (await ref
      //         .read(transactionsRepoProvider)
      //         .createTransaction(
      //           name: name,
      //           creatorUid: pecuniaUser.uid,
      //           transactionDate: DateTime.now(),
      //           accountId: accountId,
      //           type: transactionType,
      //           baseAmount: actualBaseAmount,
      //           baseCurrency: baseCurrency,
      //           transactionDescription: description,
      //           exchangeRate: exchangeRate,
      //           targetCurrency: targetCurrency,
      //           targetAmount: targetAmount,
      //         )
      //         .run())
      //     .fold(
      //   (l) => state = AsyncError(l, l.stackTrace),
      //   (r) {
      //     ref.invalidate(getAllTransactionsProvider);
      //     state = AsyncData(Option.of(r));
      //   },
      // );
      debugPrint('''
      name: $name,
      creatorUid: ${pecuniaUser.uid},
      transactionDate: ${DateTime.now()},
      accountId: $accountId,
      type: $transactionType,
      baseAmount: $baseAmount,
      actualBaseAmount: $actualBaseAmount,
      baseCurrency: $baseCurrency,
      transactionDescription: $description,
      exchangeRate: $exchangeRate,
      targetCurrency: $targetCurrency,
      targetAmount: $targetAmount,
''');
    }
  }
}

@riverpod
class DeleteTransaction extends _$DeleteTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteTransaction(Transaction txn) async {
    state = const AsyncValue.loading();

    (await ref.watch(transactionsRepoProvider).deleteTransaction(txn).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
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
  Future<List<Account>> build() async {
    return _getAllAccounts();
  }

  Future<List<Account>> _getAllAccounts() async {
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
      return (await ref.read(accountsRepoProvider).getAccounts().run()).fold(
        (l) => Future<List<Account>>.error(l, l.stackTrace),
        (r) => r,
      );
    } else {
      return Future<List<Account>>.error(
        AccountsFailure.unknown(
          stackTrace: StackTrace.current,
          message: 'This should never happen, please contact support.',
          accountsAction: AccountsAction.unknown,
        ),
        StackTrace.current,
      );
    }
  }
}

@riverpod
class GetAllTransactions extends _$GetAllTransactions {
  @override
  Future<List<Transaction>> build() async {
    return _getAllTransactions();
  }

  Future<List<Transaction>> _getAllTransactions() async {
    return (await ref.read(transactionsRepoProvider).getAllTransactions().run()).fold(
      (l) => Future<List<Transaction>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
