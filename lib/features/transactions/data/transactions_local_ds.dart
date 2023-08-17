import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/transactions/dao_tables/transactions_dao_tables.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_local_ds.g.dart';

@riverpod
TransactionsLocalDS transactionsLocalDS(TransactionsLocalDSRef ref) =>
    TransactionsLocalDSImpl(ref.watch(transactionsDAOProvider));

abstract interface class TransactionsLocalDS {
  TaskEither<TransactionsFailure, Unit> createTransaction(Transaction transaction);
  TaskEither<TransactionsFailure, Unit> createTransferTransaction({
    required Transaction sourceTransaction,
    required Transaction destinationTransaction,
  });
  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transaction);
  TaskEither<TransactionsFailure, Unit> deleteTransferTransaction(Transaction transferTxnToDelete);
  TaskEither<TransactionsFailure, Unit> editTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
  });
  TaskEither<TransactionsFailure, Unit> editTransferTxn({
    required Transaction oldSourceTxn,
    required Transaction oldDestinationTxn,
    required Transaction sourceTransaction,
    required Transaction destinationTransaction,
  });

  TaskEither<TransactionsFailure, List<TransactionDTO>> getTransactionsByAccount(String accountId);
  TaskEither<TransactionsFailure, TransactionDTO> getTransactionById(String txnId);
  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions();
}

/// My current rationale for having this layer rather than simply using the DAO directly is that
/// I might want to combine multiple local storage management packages and such.
class TransactionsLocalDSImpl implements TransactionsLocalDS {
  TransactionsLocalDSImpl(this.transactionsDAO);

  TransactionsDAO transactionsDAO;

  @override
  TaskEither<TransactionsFailure, Unit> createTransaction(Transaction transaction) {
    return transactionsDAO.createTransaction(transaction);
  }

  @override
  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions() {
    return transactionsDAO.getAllTransactions();
  }

  @override
  TaskEither<TransactionsFailure, List<TransactionDTO>> getTransactionsByAccount(String accountId) {
    return transactionsDAO.getTransactionsByAccount(accountId);
  }

  @override
  TaskEither<TransactionsFailure, TransactionDTO> getTransactionById(String txnId) {
    return transactionsDAO.getTransactionById(txnId);
  }

  @override
  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transaction) {
    return transactionsDAO.deleteTransaction(transaction);
  }

  @override
  TaskEither<TransactionsFailure, Unit> editTransaction(
      {required Transaction newTxn, required Transaction oldTxn}) {
    return transactionsDAO.editTransaction(newTxn: newTxn, oldTxn: oldTxn);
  }

  @override
  TaskEither<TransactionsFailure, Unit> editTransferTxn({
    required Transaction oldSourceTxn,
    required Transaction oldDestinationTxn,
    required Transaction sourceTransaction,
    required Transaction destinationTransaction,
  }) {
    return transactionsDAO.editTransferTxn(
      oldSourceTxn: oldSourceTxn,
      oldDestinationTxn: oldDestinationTxn,
      newSourceTxn: sourceTransaction,
      newDestinationTxn: destinationTransaction,
    );
  }

  @override
  TaskEither<TransactionsFailure, Unit> createTransferTransaction({
    required Transaction sourceTransaction,
    required Transaction destinationTransaction,
  }) {
    return transactionsDAO.createTransferTransaction(
      sourceTxn: sourceTransaction,
      destinationTxn: destinationTransaction,
    );
  }

  @override
  TaskEither<TransactionsFailure, Unit> deleteTransferTransaction(Transaction transferTxnToDelete) {
    return transactionsDAO.deleteTransferTransaction(transferTxnToDelete);
  }
}
