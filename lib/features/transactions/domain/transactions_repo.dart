import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
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
    double? exchangeRate,
    double? targetAmount,
    String? targetCurrency,
    String? transactionDescription,
  }) {
    const currentAction = TransactionsAction.create;
    final txn = Transaction.newTransaction(
      creatorUid: creatorUid,
      name: name,
      transactionDescription: TransactionDescription(transactionDescription),
      transactionDate: transactionDate,
      accountId: accountId,
      type: TransactionType.fromString(type, currentAction),
      fundDetails: FundDetails(
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
    const currentAction = TransactionsAction.getAllTransactions;
    return transactionsLocalDS.getAllTransactions().map((transactions) {
      return transactions.map((txn) => Transaction.fromDTO(txn, currentAction)).toList();
    });
  }

  TaskEither<TransactionsFailure, List<Transaction>> getTrasactionsByAccount(String accountId) {
    const currentAction = TransactionsAction.getTransactionsByAccount;
    return transactionsLocalDS.getTransactionsByAccount(accountId).map((transactions) {
      return transactions.map((txn) => Transaction.fromDTO(txn, currentAction)).toList();
    });
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
