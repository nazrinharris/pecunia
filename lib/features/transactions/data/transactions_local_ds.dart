import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions_local_ds.g.dart';

@riverpod
TransactionsLocalDS transactionsLocalDS(TransactionsLocalDSRef ref) => TransactionsLocalDSImpl();

abstract interface class TransactionsLocalDS {
  TaskEither<TransactionsFailure, Unit> createTransaction(TransactionDTO transaction);
}

class TransactionsLocalDSImpl implements TransactionsLocalDS {
  @override
  TaskEither<TransactionsFailure, Unit> createTransaction(TransactionDTO transaction) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }
}
