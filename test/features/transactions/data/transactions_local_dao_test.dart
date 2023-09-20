import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/common/description.dart' as d;
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/data/transactions_local_dao.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';

import '../../../matcher/transactions_matchers.dart';

void main() {
  late PecuniaDB db;
  late TransactionsLocalDAO transactionsLocalDAO;
  late AccountsLocalDAO accountsDAO;

  late Account testAccount;
  late Transaction testIncomeTxn;
  late Transaction testExpenseTxn;

  setUpAll(() {
    final clock = Clock.fixed(DateTime.utc(2023, 0, 0));

    db = PecuniaDB(NativeDatabase.memory());
    transactionsLocalDAO = TransactionsLocalDAO(db);
    accountsDAO = AccountsLocalDAO(db);

    testAccount = Account(
      id: 'test_id',
      creatorUid: 'test_creatorUid',
      name: 'test_name',
      initialBalance: 0,
      balance: 0,
      currency: PecuniaCurrencies.xxx,
      createdOn: clock.now().toUtc(),
      description: d.Description('test_description'),
    );

    testIncomeTxn = Transaction(
        id: 'id_income',
        creatorUid: 'creatorUid',
        name: 'name',
        transactionDescription: d.Description('input'),
        transactionDate: clock.now().toUtc(),
        accountId: testAccount.id,
        fundDetails: FundDetails(
          transactionType: TransactionType.credit,
          baseAmount: 10,
          baseCurrency: PecuniaCurrencies.fromString('XXX'),
          exchangeRate: null,
          targetAmount: null,
          targetCurrency: null,
        ),
        transferDetails: null);

    testExpenseTxn = Transaction(
      id: 'id_expense',
      creatorUid: 'creatorUid',
      name: 'name',
      transactionDescription: d.Description('input'),
      transactionDate: clock.now().toUtc(),
      accountId: testAccount.id,
      fundDetails: FundDetails(
        transactionType: TransactionType.debit,
        baseAmount: 10,
        baseCurrency: PecuniaCurrencies.fromString('XXX'),
        exchangeRate: null,
        targetAmount: null,
        targetCurrency: null,
      ),
      transferDetails: null,
    );
  });

  tearDownAll(() async => db.close());

  test('createTransaction() should create a new transaction and update the account balance correctly',
      () async {
    // Arrange
    // First, create an account with a certain balance
    // Then, prepare a transaction for this account
    await accountsDAO.createAccount(testAccount.toDTO()).run();

    // Act
    // Run createTransaction()
    await transactionsLocalDAO.createTransaction(testIncomeTxn).run();
    final txnResult = await transactionsLocalDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction is created in the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Transaction.fromDTO(dto), equals(testIncomeTxn)),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount.copyWith(balance: 10))),
    );

    // Clean up
    await transactionsLocalDAO.deleteTransaction(testIncomeTxn).run();
    await accountsDAO.deleteAccount(testAccount.toDTO()).run();
  });

  test('deleteTransaction() should delete a transaction and update the account balance correctly', () async {
    // Arrange
    // Create a transaction
    await accountsDAO.createAccount(testAccount.toDTO()).run();
    await transactionsLocalDAO.createTransaction(testIncomeTxn).run();

    // Act
    // Run deleteTransaction()
    await transactionsLocalDAO.deleteTransaction(testIncomeTxn).run();
    final txnResult = await transactionsLocalDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction is deleted from the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => expect(
        l,
        isTransactionsFailure(
          TransactionsErrorType.transactionNotFound,
        ),
      ),
      (dto) => fail('Transaction should have been deleted from the database'),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount)),
    );

    // Clean up
    await accountsDAO.deleteAccount(testAccount.toDTO()).run();
  });

  test('editTransaction() should update a transaction and adjust the account balance correctly', () async {
    // Arrange
    // Create a transaction
    await accountsDAO.createAccount(testAccount.toDTO()).run();
    await transactionsLocalDAO.createTransaction(testIncomeTxn).run();

    // Act
    // Run editTransaction() with the updated transaction data
    await transactionsLocalDAO
        .editTransaction(
          newTxn: testIncomeTxn.copyWith(
            name: 'updated_name',
            fundDetails: testIncomeTxn.fundDetails.copyWith(baseAmount: 30),
          ),
          oldTxn: testIncomeTxn,
        )
        .run();
    final txnResult = await transactionsLocalDAO.getTransactionById(testIncomeTxn.id).run();
    final accountResult = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    // Check if the transaction data is updated in the database
    // Check if the account balance is updated correctly
    txnResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(
          Transaction.fromDTO(dto),
          equals(testIncomeTxn.copyWith(
            name: 'updated_name',
            fundDetails: testIncomeTxn.fundDetails.copyWith(baseAmount: 30),
          ))),
    );
    accountResult.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount.copyWith(balance: 30))),
    );

    // Clean up
    await transactionsLocalDAO.deleteTransaction(testIncomeTxn.copyWith(name: 'updated_name')).run();
    await accountsDAO.deleteAccount(testAccount.toDTO()).run();
  });

  test('getTransactionsByAccount() should retrieve all transactions associated with a specific account',
      () async {
    // Arrange
    // Create multiple transactions for multiple accounts
    await accountsDAO.createAccount(testAccount.toDTO()).run();
    await transactionsLocalDAO.createTransaction(testIncomeTxn).run();
    await transactionsLocalDAO.createTransaction(testExpenseTxn).run();

    // Act
    // Run getTransactionsByAccount() for a specific account
    final result = await transactionsLocalDAO.getTransactionsByAccount(testAccount.id).run();

    // Assert
    // Check if the retrieved transactions match the expected set for that account
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (list) {
        final expectedList = list.map(Transaction.fromDTO).toList();
        expect(expectedList, contains(testIncomeTxn));
        expect(expectedList, contains(testExpenseTxn));
      },
    );

    // Clean up
    await transactionsLocalDAO.deleteTransaction(testIncomeTxn).run();
    await transactionsLocalDAO.deleteTransaction(testExpenseTxn).run();
    await accountsDAO.deleteAccount(testAccount.toDTO()).run();
  });

  test('getAllTransactions() should retrieve all transactions', () async {
    // Arrange
    // Create multiple transactions for multiple accounts
    await accountsDAO.createAccount(testAccount.toDTO()).run();
    await transactionsLocalDAO.createTransaction(testIncomeTxn).run();
    await transactionsLocalDAO.createTransaction(testExpenseTxn).run();

    // Act
    // Run getAllTransactions()
    final result = await transactionsLocalDAO.getAllTransactions().run();

    // Assert
    // Check if the retrieved transactions match the expected total set of transactions
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (list) {
        final expectedList = list.map(Transaction.fromDTO).toList();
        expect(expectedList, contains(testIncomeTxn));
        expect(expectedList, contains(testExpenseTxn));
      },
    );

    // Clean up
    await transactionsLocalDAO.deleteTransaction(testIncomeTxn).run();
    await transactionsLocalDAO.deleteTransaction(testExpenseTxn).run();
    await accountsDAO.deleteAccount(testAccount.toDTO()).run();
  });
}
