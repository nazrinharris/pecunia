import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/transactions/dao_tables/transactions_dao_tables.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_dao_tables.g.dart';

@riverpod
AccountsDAO accountsDAO(AccountsDAORef ref) => ref.watch(pecuniaDBProvider).accountsDAO;

@DataClassName('AccountDTO')
class AccountsTable extends Table {
  TextColumn get id => text()();
  TextColumn get creatorUid => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  RealColumn get initialBalance => real()();
  RealColumn get balance => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3)();
  DateTimeColumn get createdOn => dateTime()();
  TextColumn get description => text().withLength(min: 1, max: 500).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [AccountsTable, TransactionsTable])
class AccountsDAO extends DatabaseAccessor<PecuniaDB> with _$AccountsDAOMixin {
  AccountsDAO(super.db);

  Future<List<AccountDTO>> getAllAccounts() async {
    return select(accountsTable).get();
  }

  TaskEither<AccountsFailure, AccountDTO> getAccountById(String id) {
    return TaskEither.tryCatch(
      () async => (select(accountsTable)..where((tbl) => tbl.id.equals(id))).getSingle(),
      (error, stackTrace) => mapDriftToAccountsFailure(AccountsAction.getAccounts, error, stackTrace),
    );
  }

  TaskEither<AccountsFailure, Unit> updateAccount(AccountDTO account) {
    const accountsAction = AccountsAction.recalculateAccountBalance;
    return TaskEither.tryCatch(
      () => transaction(() async {
        // Get all transactions for this account
        final txnList =
            await (select(transactionsTable)..where((tbl) => tbl.accountId.equals(account.id))).get();

        // Calculate the new balance
        var newBalance = account.initialBalance;
        for (final txn in txnList) {
          final type = TransactionType.fromString(txn.transactionType, TransactionsAction.unknown);
          if (type == TransactionType.credit) {
            newBalance += txn.originalAmount;
          } else if (type == TransactionType.debit) {
            newBalance -= txn.originalAmount;
          } else {
            throw ArgumentError('Invalid transaction type: ${txn.transactionType}');
          }
        }

        // Update the account balance
        final updatedAccount = account.copyWith(balance: newBalance);
        await update(accountsTable).replace(updatedAccount.toCompanion(false));

        return unit;
      }),
      (error, stackTrace) => mapDriftToAccountsFailure(accountsAction, error, stackTrace),
    );
  }

  TaskEither<AccountsFailure, (bool isValid, double actualBalance)> validateAccountBalance(
      AccountDTO account) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        // Get all transactions for this account
        final txnList =
            await (select(transactionsTable)..where((tbl) => tbl.accountId.equals(account.id))).get();

        // Calculate the new balance
        var calculatedBalance = account.initialBalance;
        for (final txn in txnList) {
          final type = TransactionType.fromString(txn.transactionType, TransactionsAction.unknown);
          if (type == TransactionType.credit) {
            calculatedBalance += txn.originalAmount;
          } else if (type == TransactionType.debit) {
            calculatedBalance -= txn.originalAmount;
          } else {
            throw ArgumentError('Invalid transaction type: ${txn.transactionType}');
          }
        }

        return (calculatedBalance == account.balance, calculatedBalance);
      }),
      (error, stackTrace) => mapDriftToAccountsFailure(AccountsAction.unknown, error, stackTrace),
    );
  }

  Stream<List<AccountDTO>> watchAllAccounts() {
    return select(accountsTable).watch();
  }

  Future<void> insertAccount(AccountDTO account) async {
    await into(accountsTable).insert(account.toCompanion(false));
  }

  /// Deletes the account by the [id] from the [AccountDTO], may be changed in the future
  /// so that we can just supply the [id], but I'll keep it as is for now.
  Future<void> deleteAccount(AccountDTO account) async {
    await (delete(accountsTable)..where((tbl) => tbl.id.equals(account.id))).go();
  }
}
