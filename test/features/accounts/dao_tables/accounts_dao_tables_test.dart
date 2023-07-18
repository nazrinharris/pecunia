import 'dart:async';

import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';

void main() {
  late PecuniaDB db;
  late AccountsDAO accountsDAO;

  late Account testAccount;

  setUpAll(() {
    final clock = Clock.fixed(DateTime.utc(2023, 0, 0));

    db = PecuniaDB(NativeDatabase.memory());
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
  });

  tearDownAll(() async => db.close());

  test('insertAccount() and getAccountById() should insert and retrieve correctly', () async {
    // Arrange
    await accountsDAO.insertAccount(testAccount.toDTO());

    // Act
    final result = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount)),
    );

    // Clean up
    await accountsDAO.deleteAccount(testAccount.toDTO());
  });

  test('updateAccount() should update correctly', () async {
    // Arrange
    await accountsDAO.insertAccount(testAccount.toDTO());
    final updatedAccount = testAccount.copyWith(name: 'updated_name');

    // Act
    await accountsDAO.updateAccount(updatedAccount.toDTO()).run();
    final result = await accountsDAO.getAccountById(testAccount.id).run();

    // Assert
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(updatedAccount)),
    );

    // Clean up
    await accountsDAO.deleteAccount(updatedAccount.toDTO());
  });

  test('getAllAccounts() should retrieve all accounts', () async {
    // Arrange
    await accountsDAO.insertAccount(testAccount.toDTO());
    await accountsDAO.insertAccount(testAccount.copyWith(id: 'test_id2').toDTO());

    // Act
    final result = await accountsDAO.getAccounts().run().then((value) => value.getOrElse((f) => []));
    final resultAccounts = result.map(Account.fromDTO).toList();

    // Assert
    expect(result.length, equals(2));
    expect(resultAccounts, contains(testAccount));
    expect(resultAccounts, contains(testAccount.copyWith(id: 'test_id2')));

    // Clean up
    await accountsDAO.deleteAccount(testAccount.toDTO());
    await accountsDAO.deleteAccount(testAccount.copyWith(id: 'test_id2').toDTO());
  });

  test('deleteAccount() should remove the account from database', () async {
    // Arrange
    await accountsDAO.insertAccount(testAccount.toDTO());
    await accountsDAO.deleteAccount(testAccount.toDTO());

    // Act
    final result = await accountsDAO.getAccounts().run().then((value) => value.getOrElse((f) => []));
    final resultAccounts = result.map(Account.fromDTO).toList();

    // Assert
    expect(result.length, equals(0));
    expect(resultAccounts, isNot(contains(testAccount)));
  });

  // test('watchAllAccounts() should emit updates when accounts change', () async {
  //   // Arrange
  //   final controller = StreamController<List<Account>>();
  //   final subscription = accountsDAO.watchAllAccounts().listen(
  //         (accountDTOs) => controller.add(accountDTOs.map(Account.fromDTO).toList()),
  //       );

  //   // Act
  //   await accountsDAO.insertAccount(testAccount.toDTO());
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   await accountsDAO.deleteAccount(testAccount.toDTO());
  //   await Future<void>.delayed(const Duration(seconds: 1));

  //   // Assert
  //   expect(
  //     controller.stream,
  //     emitsInOrder([
  //       <Account>[], // Initial state
  //       [testAccount], // After insertion
  //       <Account>[] // After deletion
  //     ]),
  //   );

  //   // Clean up
  //   await subscription.cancel();
  //   await controller.close();
  // });
}
