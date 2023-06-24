import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

enum TransactionsAction {
  create,
}

abstract interface class TransactionsRepo {
  TaskEither<TransactionsFailure, Unit> createTransaction({
    required Transaction transaction,
    required TransactionsAction transactionsAction,
  });
}
