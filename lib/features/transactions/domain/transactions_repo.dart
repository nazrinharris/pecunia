import 'package:flutter/foundation.dart' as f;
import 'package:fpdart/fpdart.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/errors/txn_categories_errors/txn_categories_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/core/shared/description.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transactions_repo.g.dart';

@riverpod
TransactionsRepo transactionsRepo(TransactionsRepoRef ref) => TransactionsRepo(
      ref.watch(transactionsLocalDAOProvider),
      ref.watch(txnCategoriesLocalDAOProvider),
      ref.watch(uuidProvider),
    );

class TransactionsRepo {
  TransactionsRepo(this.transactionsLocalDAO, this.txnCategoriesLocalDAO, this.uuid);

  final TransactionsLocalDAO transactionsLocalDAO;
  final TxnCategoriesLocalDAO txnCategoriesLocalDAO;
  final TransactionsRepoHelper _helper = TransactionsRepoHelper();
  final Uuid uuid;

  TaskEither<Failure, Unit> createTransaction({
    required String name,
    required String creatorUid,
    required DateTime transactionDate,
    required String accountId,
    required String type,
    required double baseAmount,
    required String baseCurrency,
    required double? exchangeRate,
    required double? targetAmount,
    required String? targetCurrency,
    required String? transactionDescription,
    required Category? category,
  }) {
    final txn = Transaction.newTransaction(
      creatorUid: creatorUid,
      name: name,
      transactionDescription: Description(transactionDescription),
      transactionDate: transactionDate,
      accountId: accountId,
      fundDetails: FundDetails(
        transactionType: TransactionType.fromString(type),
        baseAmount: baseAmount,
        baseCurrency: PecuniaCurrencies.fromString(baseCurrency),
        exchangeRate: exchangeRate,
        targetAmount: targetAmount,
        targetCurrency: targetCurrency == null ? null : PecuniaCurrencies.fromString(targetCurrency),
      ),
      transferDetails: null,
      uuid: uuid,
    );

    return transactionsLocalDAO.createTransaction(txn, category);
  }

  // TODO: Consider if the checks should be put as asserts or not
  TaskEither<TransactionsFailure, Unit> createTransferTransaction({
    required Account sourceAccount,
    required Account destinationAccount,
    required double sourceTransactionAmount,
    required double? destinationTransactionAmount,
    required double? exchangeRate,
    required String? transferDescription,
  }) =>
      Transaction.generateTransferTxnPair(
        sourceAccount: sourceAccount,
        destinationAccount: destinationAccount,
        sourceTransactionAmount: sourceTransactionAmount,
        destinationTransactionAmount: destinationTransactionAmount,
        exchangeRate: exchangeRate,
        transferDescription: transferDescription,
        uuid: uuid,
        defaultSourceTxnId: null,
        defaultDestinationTxnId: null,
      ).toTaskEither().flatMap(
            (txns) => transactionsLocalDAO.createTransferTransaction(
                sourceTxn: txns.sourceTxn, destinationTxn: txns.destinationTxn),
          );

  TaskEither<TransactionsFailure, List<Transaction>> getAllTransactions() {
    return transactionsLocalDAO.getAllTransactions().flatMap(_helper.mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, List<Transaction>> getTransactionsByAccount(String accountId) {
    return transactionsLocalDAO
        .getTransactionsByAccount(accountId)
        .flatMap(_helper.mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, Transaction> getTransactionById(String txnId) {
    return transactionsLocalDAO.getTransactionById(txnId).map(Transaction.fromDTO);
  }

  TaskEither<Failure, Unit> editTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
    required ({Category? old, Category? current}) category,
  }) {
    return transactionsLocalDAO.editTransaction(newTxn: newTxn, oldTxn: oldTxn, category: category);
  }

  TaskEither<TransactionsFailure, Unit> editTransferTransaction({
    required Transaction oldSourceTxn,
    required Transaction oldDestinationTxn,
    required Transaction newSourceTxn,
    required Transaction newDestinationTxn,
  }) {
    return transactionsLocalDAO.editTransferTxn(
      oldSourceTxn: oldSourceTxn,
      oldDestinationTxn: oldDestinationTxn,
      newSourceTxn: newSourceTxn,
      newDestinationTxn: newDestinationTxn,
    );
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transactionToDelete) {
    return transactionsLocalDAO.deleteTransaction(transactionToDelete);
  }

  TaskEither<TransactionsFailure, Unit> deleteTransferTransaction(Transaction transferTxnToDelete) {
    return transactionsLocalDAO.deleteTransferTransaction(transferTxnToDelete);
  }

  TaskEither<TxnCategoriesFailure, List<Category>> getCategoriesByTxnId(String txnId) {
    return txnCategoriesLocalDAO.getCategoriesByTxnId(txnId);
  }

  TaskEither<TransactionsFailure, List<Transaction>> getAllIncomeTxn() {
    return transactionsLocalDAO.getAllIncomeTxns();
  }

  TaskEither<TransactionsFailure, List<Transaction>> getAllExpenseTxn() {
    return transactionsLocalDAO.getAllExpenseTxns();
  }

  TaskEither<TransactionsFailure, List<Transaction>> getTxnsOverPeriod({
    required DateTime startDate,
    required DateTime endDate,
    required TransactionType type,
    required Currency currency,
  }) {
    return transactionsLocalDAO.getTxnsOverPeriod(
      startDate: startDate,
      endDate: endDate,
      type: type,
      currency: currency,
    );
  }
}

/// This class provides utility methods for the [TransactionsRepo] class.
///
/// The [TransactionsRepoHelper] class serves to simplify the [TransactionsRepo] class by handling
/// specific tasks, such as converting [Transaction] objects to [TransactionDTO].
///
/// It is designed to keep the code in [TransactionsRepo] more clean and readable
/// by abstracting away some of the lower-level operations related to account data conversion.
@f.visibleForTesting
class TransactionsRepoHelper {
  /// Converts an [Transaction] object to an [TransactionDTO] object.
  ///
  /// If the conversion is successful, it will return a [TaskEither] with the Right side containing the [TransactionDTO].
  /// If an error occurs during the conversion, it will return a [TaskEither] with the Left side containing an [TransactionsFailure].
  TaskEither<TransactionsFailure, TransactionDTO> mapTransactionToDTO(Transaction txn) {
    return TaskEither.tryCatch(
      () async => txn.toDTO(),
      (error, stackTrace) => TransactionsFailure(
        stackTrace: stackTrace,
        message: TransactionsErrorType.cannotConvertToDTO.message,
        errorType: TransactionsErrorType.cannotConvertToDTO,
      ),
    );
  }

  TaskEither<TransactionsFailure, List<Transaction>> mapDTOListToTransactionList(
    List<TransactionDTO> dtoList,
  ) {
    return TaskEither.tryCatch(() async {
      return dtoList.map(Transaction.fromDTO).toList();
    }, (error, stackTrace) {
      if (error is TransactionsException) {
        return TransactionsFailure.fromException(error);
      }

      return TransactionsFailure(
        stackTrace: stackTrace,
        message: TransactionsErrorType.cannotConvertFromDTO.message,
        errorType: TransactionsErrorType.cannotConvertFromDTO,
      );
    });
  }

  TaskEither<TransactionsFailure, List<Transaction>> sequenceTE(
      List<TaskEither<TransactionsFailure, Transaction>> list) {
    return list.fold(
      TaskEither.right([]),
      (previous, current) => previous.flatMap((list) => current.map((value) => list..add(value))),
    );
  }
}
