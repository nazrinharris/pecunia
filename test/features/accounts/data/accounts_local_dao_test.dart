import 'dart:async';

import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/common/description.dart' as d;
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/accounts/data/accounts_local_dao.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';

void main() {
  late PecuniaDB db;
  late AccountsLocalDAO accountsLocalDAO;

  late Account testAccount;

  setUpAll(() {
    final clock = Clock.fixed(DateTime.utc(2023, 0, 0));

    db = PecuniaDB(NativeDatabase.memory());
    accountsLocalDAO = AccountsLocalDAO(db);

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
  });

  tearDownAll(() async => db.close());

  test('createAccount() and getAccountById() should insert and retrieve correctly', () async {
    // Arrange
    await accountsLocalDAO.createAccount(testAccount.toDTO()).run();

    // Act
    final result = await accountsLocalDAO.getAccountById(testAccount.id).run();

    // Assert
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(testAccount)),
    );

    // Clean up
    await accountsLocalDAO.deleteAccount(testAccount.toDTO()).run();
  });

  test('updateAccount() should update correctly', () async {
    // Arrange
    await accountsLocalDAO.createAccount(testAccount.toDTO()).run();
    final updatedAccount = testAccount.copyWith(name: 'updated_name');

    // Act
    await accountsLocalDAO.updateAccount(updatedAccount.toDTO()).run();
    final result = await accountsLocalDAO.getAccountById(testAccount.id).run();

    // Assert
    result.fold(
      (l) => fail('Operation failed with error: $l'),
      (dto) => expect(Account.fromDTO(dto), equals(updatedAccount)),
    );

    // Clean up
    await accountsLocalDAO.deleteAccount(updatedAccount.toDTO()).run();
  });

  test('getAllAccounts() should retrieve all accounts', () async {
    // Arrange
    await accountsLocalDAO.createAccount(testAccount.toDTO()).run();
    await accountsLocalDAO.createAccount(testAccount.copyWith(id: 'test_id2').toDTO()).run();

    // Act
    final result = await accountsLocalDAO.getAccounts().run().then((value) => value.getOrElse((f) => []));
    final resultAccounts = result.map(Account.fromDTO).toList();

    // Assert
    expect(result.length, equals(2));
    expect(resultAccounts, contains(testAccount));
    expect(resultAccounts, contains(testAccount.copyWith(id: 'test_id2')));

    // Clean up
    await accountsLocalDAO.deleteAccount(testAccount.toDTO()).run();
    await accountsLocalDAO.deleteAccount(testAccount.copyWith(id: 'test_id2').toDTO()).run();
  });

  test('deleteAccount() should remove the account from database', () async {
    // Arrange
    await accountsLocalDAO.createAccount(testAccount.toDTO()).run();
    await accountsLocalDAO.deleteAccount(testAccount.toDTO()).run();

    // Act
    final result = await accountsLocalDAO.getAccounts().run().then((value) => value.getOrElse((f) => []));
    final resultAccounts = result.map(Account.fromDTO).toList();

    // Assert
    expect(result.length, equals(0));
    expect(resultAccounts, isNot(contains(testAccount)));
  });

  // TODO: Fix this test, it doesn't seem to want to pass
  test('watchAllAccounts() should emit updates when accounts change', () async {
    // Arrange
    final controller = StreamController<Either<AccountsFailure, List<Account>>>();
    final expectedStream = controller.stream;
    final subscription = accountsLocalDAO.watchAccounts().listen(
      (failureOrDTOList) {
        controller.add(
          failureOrDTOList.map((dtoList) => dtoList.map(Account.fromDTO).toList()),
        );
      },
    );

    // final debug = controller.stream.listen((a) => print('Debug: $a'));

    // Act
    await accountsLocalDAO.createAccount(testAccount.toDTO()).run();
    await Future<void>.delayed(const Duration(seconds: 1));
    await accountsLocalDAO.deleteAccount(testAccount.toDTO()).run();
    await Future<void>.delayed(const Duration(seconds: 1));

    await pumpEventQueue();

    // Assert
    expect(
      expectedStream,
      emitsInOrder([
        right<AccountsFailure, List<Account>>([]), // Initial state
        right<AccountsFailure, List<Account>>([testAccount]), // After insertion
        right<AccountsFailure, List<Account>>([]), // After deletion
      ]),
    );

    // Clean up
    await subscription.cancel();
    // await debug.cancel();
    await controller.close();
  });
}
