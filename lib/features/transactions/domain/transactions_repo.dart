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
    required double originalAmount,
    required String originalCurrency,
    double? exchangeRate,
    double? exchangedToAmount,
    String? exchangedToCurrency,
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
        originalAmount: originalAmount,
        originalCurrency: originalCurrency,
        exchangeRate: exchangeRate,
        exchangedToAmount: exchangedToAmount,
        exchangedToCurrency: exchangedToCurrency,
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

  TaskEither<TransactionsFailure, Unit> deleteTransaction(Transaction transactionToDelete) {
    return transactionsLocalDS.deleteTransaction(transactionToDelete.toDTO());
  }
}
