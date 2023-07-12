import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/dao_tables/transactions_dao_tables.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';

import '../../../matcher/transactions_matchers.dart';

void main() {
  late PecuniaDB db;
  late TransactionsDAO transactionsDAO;
  late AccountsDAO accountsDAO;

  late Account testAccount;
  late Transaction testIncomeTxn;
  late Transaction testExpenseTxn;

  setUpAll(() {
    final clock = Clock.fixed(DateTime.utc(2023, 0, 0));

    db = PecuniaDB(NativeDatabase.memory());
    transactionsDAO = TransactionsDAO(db);
    accountsDAO = AccountsDAO(db);

    testAccount = Account(
      id: 'test_id',
      creatorUid: 'test_creatorUid',
      name: 'test_name',
      initialBalance: 0,
      balance: 0,
      currency: 'TST',
      createdOn: clock.now().toUtc(),
      description: AccountDescription('test_description'),
    );

    testIncomeTxn = Transaction(
      id: 'id_income',
      creatorUid: 'creatorUid',
      name: 'name',
      transactionDescription: TransactionDescription('input'),
      transactionDate: clock.now().toUtc(),
      accountId: testAccount.id,
      type: TransactionType.credit,
      fundDetails: const FundDetails(
        originalAmount: 10,
        originalCurrency: 'TST',
      ),
    );

    testExpenseTxn = Transaction(
      id: 'id_expense',
      creatorUid: 'creatorUid',
      name: 'name',
      transactionDescription: TransactionDescription('input'),
      transactionDate: clock.now().toUtc(),
      accountId: testAccount.id,
      type: TransactionType.debit,
      fundDetails: const FundDetails(
        originalAmount: 10,
        originalCurrency: 'TST',
      ),
    );
  });

  tearDownAll(() async => db.close());

  test('createTransaction() should create a new transaction and update the account balance correctly',
      () async {
    // Arrange
    // First, create an account with a certain balance
    // Then, prepare a transaction for this account
    await accountsDAO.insertAccount(testAccount.toDTO());

    // Act
    // Run createTransaction()
    await transactionsDAO.createTransaction(testIncomeTxn.toDTO()).run();
    final txnResult = await transactionsDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction is created in the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Transaction.fromDTO(dto, TransactionsAction.create), equals(testIncomeTxn)),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount.copyWith(balance: 10))),
    );

    // Clean up
    await transactionsDAO.deleteTransaction(testIncomeTxn.toDTO()).run();
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });

  test('deleteTransaction() should delete a transaction and update the account balance correctly', () async {
    // Arrange
    // Create a transaction
    await accountsDAO.insertAccount(testAccount.toDTO());
    await transactionsDAO.createTransaction(testIncomeTxn.toDTO()).run();

    // Act
    // Run deleteTransaction()
    await transactionsDAO.deleteTransaction(testIncomeTxn.toDTO()).run();
    final txnResult = await transactionsDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction is deleted from the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => expect(
        l,
        isTransactionsFailure(
          TransactionsErrorType.transactionNotFound,
          TransactionsAction.getTransactionById,
        ),
      ),
      (dto) => fail('Transaction should have been deleted from the database'),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount)),
    );

    // Clean up
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });

  test('editTransaction() should update a transaction and adjust the account balance correctly', () async {
    // Arrange
    // Create a transaction
    await accountsDAO.insertAccount(testAccount.toDTO());
    await transactionsDAO.createTransaction(testIncomeTxn.toDTO()).run();

    // Act
    // Run editTransaction() with the updated transaction data
    await transactionsDAO
        .editTransaction(
          newTxnDTO: testIncomeTxn
              .copyWith(
                name: 'updated_name',
                fundDetails: testIncomeTxn.fundDetails.copyWith(originalAmount: 30),
              )
              .toDTO(),
          oldTxnDto: testIncomeTxn.toDTO(),
        )
        .run();
    final txnResult = await transactionsDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction data is updated in the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(
          Transaction.fromDTO(dto, TransactionsAction.edit),
          equals(testIncomeTxn.copyWith(
            name: 'updated_name',
            fundDetails: testIncomeTxn.fundDetails.copyWith(originalAmount: 30),
          ))),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount.copyWith(balance: 30))),
    );

    // Clean up
    await transactionsDAO.deleteTransaction(testIncomeTxn.copyWith(name: 'updated_name').toDTO()).run();
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });

  test('getTransactionsByAccount() should retrieve all transactions associated with a specific account',
      () async {
    // Arrange
    // Create multiple transactions for multiple accounts
    await accountsDAO.insertAccount(testAccount.toDTO());
    await transactionsDAO.createTransaction(testIncomeTxn.toDTO()).run();
    await transactionsDAO.createTransaction(testExpenseTxn.toDTO()).run();

    // Act
    // Run getTransactionsByAccount() for a specific account
    final result = await transactionsDAO.getTransactionsByAccount(testAccount.id).run();

    // Assert
    // Check if the retrieved transactions match the expected set for that account
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (list) {
        final expectedList =
            list.map((dto) => Transaction.fromDTO(dto, TransactionsAction.getTransactionsByAccount)).toList();
        expect(expectedList, contains(testIncomeTxn));
        expect(expectedList, contains(testExpenseTxn));
      },
    );

    // Clean up
    await transactionsDAO.deleteTransaction(testIncomeTxn.toDTO()).run();
    await transactionsDAO.deleteTransaction(testExpenseTxn.toDTO()).run();
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });

  test('getAllTransactions() should retrieve all transactions', () async {
    // Arrange
    // Create multiple transactions for multiple accounts
    await accountsDAO.insertAccount(testAccount.toDTO());
    await transactionsDAO.createTransaction(testIncomeTxn.toDTO()).run();
    await transactionsDAO.createTransaction(testExpenseTxn.toDTO()).run();

    // Act
    // Run getAllTransactions()
    final result = await transactionsDAO.getAllTransactions().run();

    // Assert
    // Check if the retrieved transactions match the expected total set of transactions
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (list) {
        final expectedList =
            list.map((dto) => Transaction.fromDTO(dto, TransactionsAction.getAllTransactions)).toList();
        expect(expectedList, contains(testIncomeTxn));
        expect(expectedList, contains(testExpenseTxn));
      },
    );

    // Clean up
    await transactionsDAO.deleteTransaction(testIncomeTxn.toDTO()).run();
    await transactionsDAO.deleteTransaction(testExpenseTxn.toDTO()).run();
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });
}
