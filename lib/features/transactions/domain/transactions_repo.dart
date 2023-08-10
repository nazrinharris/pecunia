import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/data/transactions_local_ds.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transactions_repo.g.dart';

@riverpod
TransactionsRepo transactionsRepo(TransactionsRepoRef ref) => TransactionsRepo(
      ref.watch(transactionsLocalDSProvider),
      ref.watch(uuidProvider),
    );

enum TransactionsAction {
  create,
  createTransferTransaction,
  delete,
  edit,
  getTransactionsByAccount,
  getTransactionById,
  getAllTransactions,
  unknown,

  getTransactionAmount,
  getTransactionCurrency,
  fundDetailsFromDTO,
  mapAccountToDTO,
}

class TransactionsRepo {
  TransactionsRepo(this.transactionsLocalDS, this.uuid);

  final TransactionsLocalDS transactionsLocalDS;
  final TransactionsRepoHelper _helper = TransactionsRepoHelper();
  final Uuid uuid;

  TaskEither<TransactionsFailure, Unit> createTransaction({
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
  }) {
    const currentAction = TransactionsAction.create;
    final txn = Transaction.newTransaction(
      creatorUid: creatorUid,
      name: name,
      transactionDescription: TransactionDescription(transactionDescription),
      transactionDate: transactionDate,
      accountId: accountId,
      fundDetails: FundDetails(
        transactionType: TransactionType.fromString(type, currentAction),
        baseAmount: baseAmount,
        baseCurrency: PecuniaCurrencies.fromString(baseCurrency),
        exchangeRate: exchangeRate,
        targetAmount: targetAmount,
        targetCurrency: targetCurrency == null ? null : PecuniaCurrencies.fromString(targetCurrency),
      ),
      transferDetails: null,
      uuid: uuid,
    );

    return transactionsLocalDS.createTransaction(txn);
  }

  // TODO: Consider if the checks should be put as asserts or not
  TaskEither<TransactionsFailure, Unit> createTransferTransaction({
    required Account sourceAccount,
    required Account destinationAccount,
    required double sourceTransactionAmount,
    required double? destinationTransactionAmount,
    required double? exchangeRate,
    required String? transferDescription,
  }) {
    const currentAction = TransactionsAction.createTransferTransaction;
    final sourceTxnId = uuid.v4();
    final destinationTxnId = uuid.v4();
    final reciprocalExchangeRate = exchangeRate == null ? null : 1 / exchangeRate;
    final isMultiCurrencyTransfer = sourceAccount.currency != destinationAccount.currency;

    // ! Checks that both destinationTransactionAmount and exchangeRate is null or both are not null.
    if ((destinationTransactionAmount == null && exchangeRate != null) ||
        (destinationTransactionAmount != null && exchangeRate == null)) {
      return TaskEither.left(TransactionsFailure(
        message: TransactionsErrorType.invalidMultiCurrencyFields.message,
        errorType: TransactionsErrorType.invalidMultiCurrencyFields,
        transactionsAction: currentAction,
        stackTrace: StackTrace.current,
      ));
    }

    // ! Checks that the exchangeRate isn't null if the source and destination currencies are different.
    if (exchangeRate == null && sourceAccount.currency != destinationAccount.currency) {
      return TaskEither.left(TransactionsFailure(
        message: TransactionsErrorType.missingExchangeRateForDifferentCurrencies.message,
        errorType: TransactionsErrorType.missingExchangeRateForDifferentCurrencies,
        transactionsAction: currentAction,
        stackTrace: StackTrace.current,
      ));
    }

    // ! Checks whether the source and destination accounts are the same.
    if (sourceAccount.id == destinationAccount.id) {
      return TaskEither.left(TransactionsFailure(
        message: TransactionsErrorType.sameSourceAndDestinationAccount.message,
        errorType: TransactionsErrorType.sameSourceAndDestinationAccount,
        transactionsAction: currentAction,
        stackTrace: StackTrace.current,
      ));
    }

    // * Sets the fields for the FundDetails of the transaction (extracted for legibility)
    // * Note that a single-currency transaction assumes [exchangeRate], [targetAmount], and [targetCurrency] are null (and vice versa).
    final sourceTxnFundDetails = FundDetails(
      transactionType: TransactionType.debit,
      baseAmount: sourceTransactionAmount,
      baseCurrency: PecuniaCurrencies.fromString(sourceAccount.currency),
      exchangeRate: exchangeRate,
      targetAmount: destinationTransactionAmount,
      targetCurrency:
          isMultiCurrencyTransfer ? PecuniaCurrencies.fromString(destinationAccount.currency) : null,
    );
    final destinationTxnFundDetails = FundDetails(
      transactionType: TransactionType.credit,
      baseAmount: destinationTransactionAmount ?? sourceTransactionAmount,
      baseCurrency: PecuniaCurrencies.fromString(destinationAccount.currency),
      exchangeRate: reciprocalExchangeRate,
      targetAmount: isMultiCurrencyTransfer ? sourceTransactionAmount : null,
      targetCurrency: isMultiCurrencyTransfer ? PecuniaCurrencies.fromString(sourceAccount.currency) : null,
    );

    final sourceTxn = Transaction(
      id: sourceTxnId,
      creatorUid: sourceAccount.creatorUid,
      name: 'Transfer to ${destinationAccount.id}',
      transactionDescription: TransactionDescription(null),
      transactionDate: DateTime.now(),
      accountId: sourceAccount.id,
      fundDetails: sourceTxnFundDetails,
      transferDetails: TransferDetails(
        linkedTransactionId: destinationTxnId,
        linkedAccountId: destinationAccount.id,
        transferDescription: TransferDescription(transferDescription),
      ),
    );

    final destinationTxn = Transaction(
      id: destinationTxnId,
      creatorUid: destinationAccount.creatorUid,
      name: 'Transfer from ${sourceAccount.id}',
      transactionDescription: TransactionDescription(null),
      transactionDate: DateTime.now(),
      accountId: destinationAccount.id,
      fundDetails: destinationTxnFundDetails,
      transferDetails: TransferDetails(
        linkedTransactionId: sourceTxnId,
        linkedAccountId: sourceAccount.id,
        transferDescription: TransferDescription(transferDescription),
      ),
    );

    // print('sourceTxn: $sourceTxn');
    // print('destinationTxn: $destinationTxn');

    // return TaskEither.left(TransactionsFailure(
    //   message: 'Not implemented',
    //   errorType: TransactionsErrorType.unknown,
    //   transactionsAction: currentAction,
    //   stackTrace: StackTrace.current,
    // ));

    return transactionsLocalDS.createTransferTransaction(
      sourceTransaction: sourceTxn,
      destinationTransaction: destinationTxn,
    );
  }

  TaskEither<TransactionsFailure, List<Transaction>> getAllTransactions() {
    return transactionsLocalDS.getAllTransactions().flatMap(_helper.mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, List<Transaction>> getTransactionsByAccount(String accountId) {
    return transactionsLocalDS
        .getTransactionsByAccount(accountId)
        .flatMap(_helper.mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, Unit> editTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
  }) {
    return transactionsLocalDS.editTransaction(newTxn: newTxn, oldTxn: oldTxn);
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transactionToDelete) {
    return transactionsLocalDS.deleteTransaction(transactionToDelete);
  }
}

/// This class provides utility methods for the [TransactionsRepo] class.
///
/// The [TransactionsRepoHelper] class serves to simplify the [TransactionsRepo] class by handling
/// specific tasks, such as converting [Transaction] objects to [TransactionDTO].
///
/// It is designed to keep the code in [TransactionsRepo] more clean and readable
/// by abstracting away some of the lower-level operations related to account data conversion.
@visibleForTesting
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
        transactionsAction: TransactionsAction.mapAccountToDTO,
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
        transactionsAction: TransactionsAction.unknown,
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
