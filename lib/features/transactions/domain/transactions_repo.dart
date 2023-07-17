import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/transactions/data/transactions_local_ds.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transactions_repo.g.dart';

@riverpod
TransactionsRepo transactionsRepo(TransactionsRepoRef ref) => TransactionsRepo(
      ref.watch(transactionsLocalDSProvider),
      ref.watch(uuidProvider),
    );

enum TransactionsAction {
  create,
  delete,
  edit,
  getTransactionsByAccount,
  getTransactionById,
  getAllTransactions,
  unknown,

  getTransactionAmount,
  getTransactionCurrency,
  fundDetailsFromDTO,
  mapAccountToDTO,
}

class TransactionsRepo {
  TransactionsRepo(this.transactionsLocalDS, this.uuid);

  final TransactionsLocalDS transactionsLocalDS;
  final Uuid uuid;

  TaskEither<TransactionsFailure, Unit> createTransaction({
    required String name,
    required String creatorUid,
    required DateTime transactionDate,
    required String accountId,
    required String type,
    required double baseAmount,
    required String baseCurrency,
    required double? exchangeRate,
    required double? targetAmount,
    required String? targetCurrency,
    required String? transactionDescription,
  }) {
    const currentAction = TransactionsAction.create;
    final txn = Transaction.newTransaction(
      creatorUid: creatorUid,
      name: name,
      transactionDescription: TransactionDescription(transactionDescription),
      transactionDate: transactionDate,
      accountId: accountId,
      fundDetails: FundDetails(
        transactionType: TransactionType.fromString(type, currentAction),
        baseAmount: baseAmount,
        baseCurrency: baseCurrency,
        exchangeRate: exchangeRate,
        targetAmount: targetAmount,
        targetCurrency: targetCurrency,
      ),
      uuid: uuid,
    );

    return transactionsLocalDS.createTransaction(txn.toDTO());
  }

  TaskEither<TransactionsFailure, List<Transaction>> getAllTransactions() {
    return transactionsLocalDS
        .getAllTransactions()
        .flatMap(TransactionsRepoHelper().mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, List<Transaction>> getTrasactionsByAccount(String accountId) {
    return transactionsLocalDS
        .getTransactionsByAccount(accountId)
        .flatMap(TransactionsRepoHelper().mapDTOListToTransactionList);
  }

  TaskEither<TransactionsFailure, Unit> updateTransaction({
    required Transaction newTxn,
    required Transaction oldTxn,
  }) {
    return transactionsLocalDS.updateTransaction(newTxnDTO: newTxn.toDTO(), oldTxnDto: oldTxn.toDTO());
  }

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transactionToDelete) {
    return transactionsLocalDS.deleteTransaction(transactionToDelete.toDTO());
  }
}

/// This class provides utility methods for the [TransactionsRepo] class.
///
/// The [TransactionsRepoHelper] class serves to simplify the [TransactionsRepo] class by handling
/// specific tasks, such as converting [Transaction] objects to [TransactionDTO].
///
/// It is designed to keep the code in [TransactionsRepo] more clean and readable
/// by abstracting away some of the lower-level operations related to account data conversion.
class TransactionsRepoHelper {
  /// Converts an [Transaction] object to an [TransactionDTO] object.
  ///
  /// If the conversion is successful, it will return a [TaskEither] with the Right side containing the [TransactionDTO].
  /// If an error occurs during the conversion, it will return a [TaskEither] with the Left side containing an [TransactionsFailure].
  TaskEither<TransactionsFailure, TransactionDTO> mapTransactionToDTO(Transaction txn) {
    return TaskEither.tryCatch(
      () async => txn.toDTO(),
      (error, stackTrace) => TransactionsFailure(
        stackTrace: stackTrace,
        message: TransactionsErrorType.cannotConvertToDTO.message,
        errorType: TransactionsErrorType.cannotConvertToDTO,
        transactionsAction: TransactionsAction.mapAccountToDTO,
      ),
    );
  }

  TaskEither<TransactionsFailure, List<Transaction>> mapDTOListToTransactionList(
    List<TransactionDTO> dtoList,
  ) {
    return TaskEither.tryCatch(() async {
      return dtoList.map(Transaction.fromDTO).toList();
    }, (error, stackTrace) {
      if (error is TransactionsException) {
        return TransactionsFailure.fromException(error);
      }

      return TransactionsFailure(
        stackTrace: stackTrace,
        message: TransactionsErrorType.cannotConvertFromDTO.message,
        errorType: TransactionsErrorType.cannotConvertFromDTO,
        transactionsAction: TransactionsAction.unknown,
      );
    });
  }

  TaskEither<TransactionsFailure, List<Transaction>> sequenceTE(
      List<TaskEither<TransactionsFailure, Transaction>> list) {
    return list.fold(
      TaskEither.right([]),
      (previous, current) => previous.flatMap((list) => current.map((value) => list..add(value))),
    );
  }
}
