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

  /// The id of the transaction that this transaction is a transfer of.
  TextColumn get transferLinkId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [
  TransactionsTable,
  AccountsTable,
])
class TransactionsDAO extends DatabaseAccessor<PecuniaDB> with _$TransactionsDAOMixin {
  TransactionsDAO(super.db);

  TaskEither<TransactionsFailure, Unit> createTransaction(TransactionDTO txnDto) {
    const currentAction = TransactionsAction.create;
    return TaskEither.tryCatch(
      () async {
        return transaction(() async {
          await insertTransactionToTable(txnDto);
          final accountDto = await retrieveAccountById(txnDto);
          final txnType = TransactionType.fromString(txnDto.transactionType, currentAction);
          final updatedAccountDTO = _calculateBalanceByOneTransaction(
            accountDto: accountDto,
            txnDto: txnDto,
            txnType: txnType,
          );
          await updateAccountDTO(updatedAccountDTO);
        }).then((_) => unit);
      },
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(TransactionDTO txnDto) {
    const currentAction = TransactionsAction.delete;
    return TaskEither.tryCatch(
      () async => transaction(() async {
        final accountDto = await retrieveAccountById(txnDto);
        final txnType = TransactionType.fromString(txnDto.transactionType, currentAction);
        final updatedAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: accountDto,
          txnDto: txnDto,
          txnType: txnType,
          shouldReverseTransaction: true,
        );

        await updateAccountDTO(updatedAccountDTO);
        await (delete(transactionsTable)..where((tbl) => tbl.id.equals(txnDto.id))).go();
        return unit;
      }),
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  TaskEither<TransactionsFailure, Unit> editTransaction({
    required TransactionDTO newTxnDTO,
    required TransactionDTO oldTxnDto,
  }) {
    const currentAction = TransactionsAction.edit;
    return TaskEither.tryCatch(
      () async => transaction(() async {
        // Retrieve and setup required data
        final accountDto = await retrieveAccountById(oldTxnDto);
        final oldTxnType = TransactionType.fromString(oldTxnDto.transactionType, currentAction);
        final newTxnType = TransactionType.fromString(newTxnDTO.transactionType, currentAction);

        // Remove the old transaction from the balance
        final removedOldTxnAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: accountDto,
          txnDto: oldTxnDto,
          txnType: oldTxnType,
          shouldReverseTransaction: true,
        );

        // Add the new transaction to the balance
        final updatedAccountDTO = _calculateBalanceByOneTransaction(
          accountDto: removedOldTxnAccountDTO,
          txnDto: newTxnDTO,
          txnType: newTxnType,
        );

        // Update the account and transactions
        await updateAccountDTO(updatedAccountDTO);
        await (update(transactionsTable)..where((tbl) => tbl.id.equals(oldTxnDto.id)))
            .write(newTxnDTO.toCompanion(true));
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
    required TransactionDTO txnDto,
    required TransactionType txnType,
    bool shouldReverseTransaction = false,
  }) {
    double newBalance;
    if (txnType == TransactionType.credit) {
      newBalance = shouldReverseTransaction
          ? accountDto.balance - txnDto.transactionAmount
          : accountDto.balance + txnDto.transactionAmount;
    } else {
      newBalance = shouldReverseTransaction
          ? accountDto.balance + txnDto.transactionAmount
          : accountDto.balance - txnDto.transactionAmount;
    }
    return accountDto.copyWith(balance: newBalance);
  }
}
