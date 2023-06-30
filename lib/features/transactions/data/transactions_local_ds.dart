import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/transactions/dao_tables/transactions_dao_tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_local_ds.g.dart';

@riverpod
TransactionsLocalDS transactionsLocalDS(TransactionsLocalDSRef ref) =>
    TransactionsLocalDSImpl(ref.watch(transactionsDAOProvider));

abstract interface class TransactionsLocalDS {
  TaskEither<TransactionsFailure, Unit> createTransaction(TransactionDTO transaction);

  TaskEither<TransactionsFailure, List<TransactionDTO>> getTransactionsByAccount(String accountId);
  TaskEither<TransactionsFailure, List<TransactionDTO>> getAllTransactions();
}

/// My current rationale for having this layer rather than simply using the DAO directly is that
/// I might want to combine multiple local storage management packages and such.
class TransactionsLocalDSImpl implements TransactionsLocalDS {
  TransactionsLocalDSImpl(this.transactionsDAO);

  TransactionsDAO transactionsDAO;

  @override
  TaskEither<TransactionsFailure, Unit> createTransaction(TransactionDTO transaction) {
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
}
