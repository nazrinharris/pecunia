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
  RealColumn get originalAmount => real()();
  TextColumn get originalCurrency => text().withLength(min: 3, max: 3)();
  RealColumn get exchangeRate => real().nullable()();
  RealColumn get exchangedToAmount => real().nullable()();
  TextColumn get exchangedToCurrency => text().withLength(min: 3, max: 3).nullable()();

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
          await _insertTransactionToTable(txnDto);
          final accountDto = await _retrieveAccountById(txnDto);
          final txnType = TransactionType.fromString(txnDto.transactionType, currentAction);
          final newBalance = _calculateBalanceByOneTransaction(accountDto, txnDto, txnType);
          await _updateAccountBalance(accountDto, newBalance);
        }).then((_) => unit);
      },
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

  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions() {
    const currentAction = TransactionsAction.getAllTransactions;
    return TaskEither.tryCatch(
      () async => select(transactionsTable).get(),
      (error, stackTrace) => mapDriftToTransactionsFailure(currentAction, error, stackTrace),
    );
  }

  /// ********************************************************************************************************
  /// DAO Private Methods, these methods are extracted to improve legibility of the DAO methods. These methods
  /// must be directly related to the database actions.
  /// ********************************************************************************************************

  Future<AccountDTO> _retrieveAccountById(TransactionDTO txnDto) async {
    return (select(accountsTable)..where((tbl) => tbl.id.equals(txnDto.accountId))).getSingle();
  }

  Future<void> _insertTransactionToTable(TransactionDTO txnDto) async {
    await into(transactionsTable).insert(txnDto.toCompanion(false));
  }

  Future<void> _updateAccountBalance(AccountDTO accountDto, double newBalance) async {
    await update(accountsTable).replace(accountDto.copyWith(balance: newBalance).toCompanion(true));
  }

  /// ********************************************************************************************************
  /// Other private methods, also extracted for legibility. These methods should not be executing actions
  /// on the database.
  /// ********************************************************************************************************

  /// Calculates the new balance of an account based on a single transaction.
  ///
  /// Takes in an [AccountDTO] object representing the account, a [TransactionDTO]
  /// object representing the transaction, and a [TransactionType] enum value
  /// representing the type of the transaction (credit or debit).
  ///
  /// Returns a [double] value representing the new balance of the account after
  /// the transaction has been applied.
  double _calculateBalanceByOneTransaction(
      AccountDTO accountDto, TransactionDTO txnDto, TransactionType txnType) {
    double newBalance;
    if (txnType == TransactionType.credit) {
      newBalance = accountDto.balance + txnDto.originalAmount;
    } else {
      newBalance = accountDto.balance - txnDto.originalAmount;
    }
    return newBalance;
  }
}
