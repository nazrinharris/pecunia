import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_local_dao.g.dart';

@riverpod
AccountsLocalDAO accountsLocalDAO(AccountsLocalDAORef ref) =>
    ref.watch(pecuniaDBProvider).requireValue.accountsLocalDAO;

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
class AccountsLocalDAO extends DatabaseAccessor<PecuniaDriftDB> with _$AccountsLocalDAOMixin {
  AccountsLocalDAO(super.db);

  TaskEither<AccountsFailure, List<AccountDTO>> getAccounts() {
    return TaskEither.tryCatch(
      () async => (select(accountsTable)
            ..orderBy([
              (tbl) => OrderingTerm(expression: tbl.name),
            ]))
          .get(),
      mapDriftToAccountsFailure,
    );
  }

  TaskEither<AccountsFailure, AccountDTO> getAccountById(String id) {
    return TaskEither.tryCatch(
      () async => (select(accountsTable)..where((tbl) => tbl.id.equals(id))).getSingle(),
      mapDriftToAccountsFailure,
    );
  }

  TaskEither<AccountsFailure, Unit> updateAccount(AccountDTO account) {
    return TaskEither.tryCatch(
      () => transaction(() async {
        // Get all transactions for this account
        final txnList =
            await (select(transactionsTable)..where((tbl) => tbl.accountId.equals(account.id))).get();

        // Calculate the new balance
        var newBalance = account.initialBalance;
        for (final txn in txnList) {
          final type = TransactionType.fromString(txn.transactionType);
          if (type == TransactionType.credit) {
            newBalance += txn.transactionAmount;
          } else if (type == TransactionType.debit) {
            newBalance -= txn.transactionAmount;
          } else {
            throw ArgumentError('Invalid transaction type: ${txn.transactionType}');
          }
        }

        // Update the account balance
        final updatedAccount = account.copyWith(balance: newBalance);
        await update(accountsTable).replace(updatedAccount.toCompanion(false));

        return unit;
      }),
      mapDriftToAccountsFailure,
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
          final type = TransactionType.fromString(txn.transactionType);
          if (type == TransactionType.credit) {
            calculatedBalance += txn.transactionAmount;
          } else if (type == TransactionType.debit) {
            calculatedBalance -= txn.transactionAmount;
          } else {
            throw ArgumentError('Invalid transaction type: ${txn.transactionType}');
          }
        }

        return (calculatedBalance == account.balance, calculatedBalance);
      }),
      mapDriftToAccountsFailure,
    );
  }

  /// This honestly feels like a frankensteins job. I'm not sure if this is the
  /// right way to do it. But it works. So I'm going to leave it as is for now.
  ///
  /// Another solution is to simply return the pure stream, though I'm not sure
  /// on how I'd handle the errors in that case.
  Stream<Either<AccountsFailure, List<AccountDTO>>> watchAccounts() {
    return select(accountsTable).watch().transform(StreamTransformer.fromHandlers(
          handleData: (listOfDTOs, sink) {
            sink.add(
              right(listOfDTOs),
            );
          },
          handleError: (error, stackTrace, sink) {
            sink.add(
              left(mapDriftToAccountsFailure(error, stackTrace)),
            );
          },
        ));
  }

  TaskEither<AccountsFailure, Unit> createAccount(AccountDTO account) {
    return TaskEither.tryCatch(
      () async {
        await into(accountsTable).insert(account.toCompanion(false));
        return unit;
      },
      mapDriftToAccountsFailure,
    );
  }

  TaskEither<Failure, Unit> deleteAccount(String accountId) {
    return TaskEither.tryCatch(
      () async {
        return transaction(() async {
          // Delete linked transactions
          final linkedTxnList =
              await (select(transactionsTable)..where((tbl) => tbl.linkedAccountId.equals(accountId))).get();

          if (linkedTxnList.isNotEmpty) {
            for (final linkedTxn in linkedTxnList) {
              (await db.transactionsLocalDAO.deleteTransferTransaction(Transaction.fromDTO(linkedTxn)).run())
                  .fold(
                (l) => throw AccountsException.fromGenericFailure(l),
                (r) => unit,
              );
            }
          }

          // Delete this account's transactions
          (await db.transactionsLocalDAO.deleteTransactionsByAccountId(accountId).run()).fold(
            (l) => throw TransactionsException.fromFailure(l),
            (r) => unit,
          );

          // Delete this account
          await (delete(accountsTable)..where((tbl) => tbl.id.equals(accountId))).go();

          return unit;
        });
      },
      (error, stackTrace) {
        if (error is TransactionsException) {
          return TransactionsFailure.fromException(error);
        } else {
          return mapDriftToAccountsFailure(error, stackTrace);
        }
      },
    );
  }
}
