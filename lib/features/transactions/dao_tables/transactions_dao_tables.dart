import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_dao_tables.g.dart';

@riverpod
TransactionsDAO transactionsDAO(TransactionsDAORef ref) => ref.watch(pecuniaDBProvider).transactionsDAO;

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
])
class TransactionsDAO extends DatabaseAccessor<PecuniaDB> with _$TransactionsDAOMixin {
  TransactionsDAO(super.db);

  TaskEither<TransactionsFailure, Unit> createTransaction(Transaction txn) {
    const currentAction = TransactionsAction.create;
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
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction txn) {
    const currentAction = TransactionsAction.delete;
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
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, Unit> editTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
  }) {
    const currentAction = TransactionsAction.edit;
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
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, List<TransactionDTO>> getTransactionsByAccount(String accountId) {
    const currentAction = TransactionsAction.getTransactionsByAccount;
    return TaskEither.tryCatch(
      () async {
        return (select(transactionsTable)..where((tbl) => tbl.accountId.equals(accountId))).get();
      },
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, TransactionDTO> getTransactionById(String txnId) {
    const currentAction = TransactionsAction.getTransactionById;
    return TaskEither.tryCatch(
      () async {
        final result =
            await (select(transactionsTable)..where((tbl) => tbl.id.equals(txnId))).getSingleOrNull();

        if (result == null) {
          throw TransactionsException(
            stackTrace: StackTrace.current,
            errorType: TransactionsErrorType.transactionNotFound,
            transactionsAction: currentAction,
          );
        } else {
          return result;
        }
      },
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions() {
    const currentAction = TransactionsAction.getAllTransactions;
    return TaskEither.tryCatch(
      () async => select(transactionsTable).get(),
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  // ********************************************************************************************************
  // DAO Private Methods, these methods are extracted to improve legibility of the DAO methods. These methods
  // must be directly related to the database actions.
  // ********************************************************************************************************

  Future<AccountDTO> retrieveAccountById(TransactionDTO txnDto) async {
    return (select(accountsTable)..where((tbl) => tbl.id.equals(txnDto.accountId))).getSingle();
  }

  Future<void> insertTransactionToTable(TransactionDTO txnDto) async {
    await into(transactionsTable).insert(txnDto.toCompanion(false));
  }

  Future<void> updateAccountDTO(AccountDTO accountDto) async {
    await update(accountsTable).replace(accountDto.toCompanion(false));
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
