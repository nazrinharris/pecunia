import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/drift/txn_categories_local_dao.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';

import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_local_dao.g.dart';

@riverpod
TransactionsLocalDAO transactionsLocalDAO(TransactionsLocalDAORef ref) =>
    ref.watch(pecuniaDBProvider).transactionsLocalDAO;

@DataClassName('TransactionDTO')
class TransactionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get creatorUid => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 500).nullable()();
  DateTimeColumn get transactionDate => dateTime()();

  TextColumn get accountId => text().references(AccountsTable, #id)();
  TextColumn get transactionType => text()();

  // These fields are kept in [FundDetails]
  RealColumn get transactionAmount => real()();
  RealColumn get baseAmount => real()();
  TextColumn get baseCurrency => text().withLength(min: 3, max: 3)();
  RealColumn get exchangeRate => real().nullable()();
  RealColumn get targetAmount => real().nullable()();
  TextColumn get targetCurrency => text().withLength(min: 3, max: 3).nullable()();

  /// These fields are kept in [TransferDetails].
  TextColumn get linkedTransactionId => text().nullable().references(TransactionsTable, #id)();
  TextColumn get linkedAccountId => text().nullable().references(AccountsTable, #id)();
  TextColumn get transferDescription => text().withLength(min: 1, max: 500).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// The Data Access Object for the [TransactionsTable] table.
///
/// Note: This DAO and the data structure assumes null means the field is empty. So if null is provided,
/// null will be the value. Therefore, `.toCompanion(false)` must be used. This will ensure that the
/// null fields aren't treated as "not changed". This also means that to update a field, you must first
/// retrieve the whole row, then use the `copyWith` method.
@DriftAccessor(tables: [
  TransactionsTable,
  AccountsTable,
  CategoriesTable,
  TxnCategoriesTable,
])
class TransactionsLocalDAO extends DatabaseAccessor<PecuniaDB> with _$TransactionsLocalDAOMixin {
  TransactionsLocalDAO(super.db);

  TaskEither<TransactionsFailure, Unit> createTransaction(Transaction txn) {
    return TaskEither.tryCatch(
      () async {
        return transaction(() async {
          await insertTransactionToTable(txn.toDTO());
          final accountDto = await retrieveAccountById(txn.toDTO());
          final updatedAccountDTO = _calculateBalanceByOneTransaction(
            accountDto: accountDto,
            txn: txn,
          );
          await updateAccountDTO(updatedAccountDTO);
        }).then((_) => unit);
      },
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, Unit> createTransferTransaction({
    required Transaction sourceTxn,
    required Transaction destinationTxn,
  }) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        // Settle the [sourceTxn]
        await insertTransactionToTable(sourceTxn.toDTO());
        final sourceAccountDTO = await retrieveAccountById(sourceTxn.toDTO());
        final updatedSourceAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: sourceAccountDTO,
          txn: sourceTxn,
        );
        await updateAccountDTO(updatedSourceAccountDTO);
        await _validateAccountBalance(sourceTxn.accountId);

        // Settle the [destinationTxn]
        await insertTransactionToTable(destinationTxn.toDTO());
        final destinationAccountDTO = await retrieveAccountById(destinationTxn.toDTO());
        final updatedDestinationAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: destinationAccountDTO,
          txn: destinationTxn,
        );
        await updateAccountDTO(updatedDestinationAccountDTO);
        await _validateAccountBalance(destinationTxn.accountId);

        return unit;
      }),
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction txn) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        final accountDto = await retrieveAccountById(txn.toDTO());
        final updatedAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: accountDto,
          txn: txn,
          shouldReverseTransaction: true,
        );

        await updateAccountDTO(updatedAccountDTO);
        await (delete(transactionsTable)..where((tbl) => tbl.id.equals(txn.id))).go();
        return unit;
      }),
      mapDriftToTransactionsFailure,
    );
  }

  /// This method will delete both the provided [transferTxnToDelete] as well as its `linkedTxn`
  TaskEither<TransactionsFailure, Unit> deleteTransferTransaction(Transaction transferTxnToDelete) {
    return TaskEither.tryCatch(
      () => transaction(() async {
        // Ensure that the transaction is a transfer
        if (!transferTxnToDelete.isTransferTransaction) {
          throw TransactionsException(
            stackTrace: StackTrace.current,
            errorType: TransactionsErrorType.notATransferTransaction,
          );
        }

        // Get the transaction, if an error occurs, this database transaction should fail
        final linkedTxn =
            (await getTransactionById(transferTxnToDelete.transferDetails!.linkedTransactionId).run()).fold(
          (l) => throw TransactionsException.fromFailure(l),
          Transaction.fromDTO,
        );

        // Delete the source and destination transactions, if an error occurs, this database transaction should fail
        (await deleteTransaction(transferTxnToDelete).run()).fold(
          (l) => throw TransactionsException.fromFailure(l),
          (r) => unit,
        );
        await _validateAccountBalance(transferTxnToDelete.accountId);

        (await deleteTransaction(linkedTxn).run()).fold(
          (l) => throw TransactionsException.fromFailure(l),
          (r) => unit,
        );
        await _validateAccountBalance(linkedTxn.accountId);

        return unit;
      }),
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, Unit> editTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
  }) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        // Retrieve and setup required data
        final accountDto = await retrieveAccountById(oldTxn.toDTO());

        // Remove the old transaction from the balance
        final removedOldTxnAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: accountDto,
          txn: oldTxn,
          shouldReverseTransaction: true,
        );

        // Add the new transaction to the balance
        final updatedAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: removedOldTxnAccountDTO,
          txn: newTxn,
        );

        // Update the account and transactions
        await updateAccountDTO(updatedAccountDTO);
        await (update(transactionsTable)..where((tbl) => tbl.id.equals(oldTxn.id)))
            .write(newTxn.toDTO().toCompanion(false));
        return unit;
      }),
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, Unit> editTransferTxn({
    required Transaction oldSourceTxn,
    required Transaction oldDestinationTxn,
    required Transaction newSourceTxn,
    required Transaction newDestinationTxn,
  }) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        // Delete both transactions
        (await deleteTransferTransaction(oldSourceTxn).run()).fold(
          (l) => throw TransactionsException.fromFailure(l),
          (r) => r,
        );

        // Create both transactions
        (await createTransferTransaction(
          sourceTxn: newSourceTxn,
          destinationTxn: newDestinationTxn,
        ).run())
            .fold(
          (l) => throw TransactionsException.fromFailure(l),
          (r) => r,
        );

        return unit;
      }),
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, List<TransactionDTO>> getTransactionsByAccount(String accountId) {
    return TaskEither.tryCatch(
      () async {
        return (select(transactionsTable)..where((tbl) => tbl.accountId.equals(accountId))).get();
      },
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, TransactionDTO> getTransactionById(String txnId) {
    return TaskEither.tryCatch(
      () async {
        final result =
            await (select(transactionsTable)..where((tbl) => tbl.id.equals(txnId))).getSingleOrNull();

        if (result == null) {
          throw TransactionsException(
            stackTrace: StackTrace.current,
            errorType: TransactionsErrorType.transactionNotFound,
          );
        } else {
          return result;
        }
      },
      mapDriftToTransactionsFailure,
    );
  }

  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions() {
    return TaskEither.tryCatch(
      () async => select(transactionsTable).get(),
      mapDriftToTransactionsFailure,
    );
  }

  // ********************************************************************************************************
  // DAO Private Methods, these methods are extracted to improve legibility of the DAO methods. These methods
  // must be directly related to the database actions.
  // ********************************************************************************************************

  Future<AccountDTO> retrieveAccountById(TransactionDTO txnDto) async {
    return (select(accountsTable)..where((tbl) => tbl.id.equals(txnDto.accountId))).getSingle();
  }

  Future<TransactionDTO> retrieveTransactionById(String id) async {
    return (select(transactionsTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> insertTransactionToTable(TransactionDTO txnDto) async {
    await into(transactionsTable).insert(txnDto.toCompanion(false));
  }

  Future<void> updateAccountDTO(AccountDTO accountDto) async {
    await update(accountsTable).replace(accountDto.toCompanion(false));
  }

  Future<(bool isValid, double actualBalance)> _validateAccountBalance(String accountId) async {
    final account = await (select(accountsTable)..where((tbl) => tbl.id.equals(accountId))).getSingle();

    // Get all transactions for this account
    final txnList = await (select(transactionsTable)..where((tbl) => tbl.accountId.equals(account.id))).get();

    // Calculate the new balance
    var calculatedBalance = account.initialBalance;
    for (final txn in txnList) {
      final type = TransactionType.fromString(txn.transactionType);
      if (type == TransactionType.credit) {
        calculatedBalance += txn.transactionAmount;
      } else if (type == TransactionType.debit) {
        calculatedBalance -= txn.transactionAmount;
      } else {
        throw ArgumentError('Invalid transaction type: ${txn.transactionType}');
      }
    }

    if (calculatedBalance != account.balance) {
      throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.mismatchAccountBalance,
      );
    }

    return (calculatedBalance == account.balance, calculatedBalance);
  }

  // ********************************************************************************************************
  // Other private methods, extracted for legibility. These methods should not be executing actions
  // on the database.
  // ********************************************************************************************************

  /// Calculates the new balance of an account based on a single transaction.
  ///
  /// Takes in an [AccountDTO] object representing the account, a [TransactionDTO]
  /// object representing the transaction, and a [TransactionType] enum value
  /// representing the type of the transaction (credit or debit).
  ///
  /// The [shouldReverseTransaction] parameter represents if the transaction needs
  /// to be reversed (true) or applied normally (false). When true, the operation
  /// of the transaction type is inverted - debits will add to the balance,
  /// and credits will subtract. Useful when, for example, deleting a transaction.
  ///
  /// Returns an [AccountDTO] with the updated balance after
  /// the transaction has been applied (or reversed, if shouldReverseTransaction is true).
  AccountDTO _calculateBalanceByOneTransaction({
    required AccountDTO accountDto,
    required Transaction txn,
    bool shouldReverseTransaction = false,
  }) {
    double newBalance;
    if (txn.fundDetails.transactionType == TransactionType.credit) {
      newBalance = shouldReverseTransaction
          ? accountDto.balance - txn.fundDetails.transactionAmount
          : accountDto.balance + txn.fundDetails.transactionAmount;
    } else {
      newBalance = shouldReverseTransaction
          ? accountDto.balance + txn.fundDetails.transactionAmount
          : accountDto.balance - txn.fundDetails.transactionAmount;
    }
    return accountDto.copyWith(balance: newBalance);
  }
}
