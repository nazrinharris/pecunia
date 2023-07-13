import 'package:clock/clock.dart';
import 'package:drift/isolate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/accounts/data/accounts_local_ds.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:uuid/uuid.dart';

import '../../../matcher/accounts_matchers.dart';

class MockAccountsDAO extends Mock implements AccountsDAO {}

class MockUUID extends Mock implements Uuid {}

void main() {
  late MockAccountsDAO mockAccountsDAO;
  late MockUUID mockUuid;
  late AccountsLocalDS accountsLocalDS;

  late AccountDTO testAccountDTO;
  late List<AccountDTO> testAccountsDTOList;

  setUp(() {
    final clock = Clock.fixed(DateTime.utc(2023));

    mockAccountsDAO = MockAccountsDAO();
    mockUuid = MockUUID();
    accountsLocalDS = AccountsLocalDSImpl(accountsDAO: mockAccountsDAO, uuid: mockUuid);

    testAccountDTO = AccountDTO(
      id: 'testId',
      creatorUid: 'testCreatorUid',
      name: 'testName',
      initialBalance: 0,
      balance: 0,
      currency: 'TST',
      createdOn: clock.now(),
      description: 'testDescription',
    );

    testAccountsDTOList = [testAccountDTO, testAccountDTO];

    registerFallbackValue(testAccountDTO);
  });

  group('AccountsLocalDS -', () {
    group('getAccounts()', () {
      test('returns a list of [AccountDTO] when the call to accountsDAO is successful', () async {
        // Arrange
        when(() => mockAccountsDAO.getAllAccounts()).thenAnswer((_) => Future.value(testAccountsDTOList));

        // Act
        final result = await accountsLocalDS.getAccounts().run();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) => expect(r, equals(testAccountsDTOList)),
        );
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.getAccounts] with the correct [AccountsErrorType] when the call to accountsDAO throws an error',
          () async {
        // Arrange
        when(() => mockAccountsDAO.getAllAccounts()).thenThrow(DriftRemoteException);

        // Act
        final result = await accountsLocalDS.getAccounts().run();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => isAccountsFailure(AccountsErrorType.unknown, AccountsAction.getAccounts),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('watchAccounts()', () {
      test('returns a stream of [Right<AccountsFailure, List<AccountDTO>>] on successful data fetch', () {
        // Arrange
        when(() => mockAccountsDAO.watchAllAccounts())
            .thenAnswer((_) => Stream.fromIterable([testAccountsDTOList]));

        // Act
        final result = accountsLocalDS.watchAccounts();

        // Assert
        expect(
          result,
          emitsInOrder([
            right<AccountsFailure, List<AccountDTO>>(testAccountsDTOList),
            emitsDone,
          ]),
        );
      });

      test('returns a stream of [Left<AccountsFailure, List<AccountDTO>>] on data fetch error', () {
        // Arrange
        when(() => mockAccountsDAO.watchAllAccounts()).thenAnswer((_) => Stream.error(Exception()));

        // Act
        final result = accountsLocalDS.watchAccounts();

        // Assert
        // ignore: cascade_invocations
        result.listen(
          (either) {
            expect(either.isLeft(), isTrue);
            either.fold(
              (l) => isAccountsFailure(AccountsErrorType.unknown, AccountsAction.watchAccounts),
              (r) => fail('Operation succeeded with value: $r'),
            );
          },
          onError: (_) {},
        );
      });
    });

    group('createAccount()', () {
      test('returns [Unit] when creating account is successful', () async {
        // Arrange
        when(() => mockAccountsDAO.insertAccount(any())).thenAnswer((_) async {});
        when(() => mockUuid.v4()).thenReturn('testId');

        // Act
        final result = await accountsLocalDS.createAccount(testAccountDTO).run();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) => expect(r, unit),
        );

        // Verify that insertAccount was called
        final captured = verify(() => mockAccountsDAO.insertAccount(captureAny())).captured;
        final capturedDTO = captured[0] as AccountDTO;
        expect(capturedDTO.name, testAccountDTO.name);
        expect(capturedDTO.creatorUid, testAccountDTO.creatorUid);
        expect(capturedDTO.initialBalance, testAccountDTO.initialBalance);
        expect(capturedDTO.balance, testAccountDTO.balance);
        expect(capturedDTO.currency, testAccountDTO.currency);
        expect(capturedDTO.description, testAccountDTO.description);
      });

      test(
          'returns [AccountsFailure] with [AccountsAction.createAccount] and correct [AccountsErrorType] when creating account is unsuccessful',
          () async {
        // Arrange
        when(() => mockAccountsDAO.insertAccount(any())).thenThrow(Exception());
        when(() => mockUuid.v4()).thenReturn('testId');

        // Act
        final result = await accountsLocalDS.createAccount(testAccountDTO).run();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, AccountsAction.createAccount)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('updateAccountDetails()', () {
      final updatedAccountDTO = AccountDTO(
        id: 'testId',
        creatorUid: 'testCreatorUid',
        name: 'testName',
        initialBalance: 0,
        balance: 0,
        currency: 'TST',
        createdOn: clock.now(),
        description: 'testDescription',
      );

      test('returns [Unit] when updating account is successful', () async {
        // Arrange
        when(() => mockAccountsDAO.updateAccount(any())).thenAnswer((_) => TaskEither.right(unit));

        // Act
        final result = await accountsLocalDS.updateAccountDetails(updatedAccountDTO).run();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) => expect(r, unit),
        );

        // Verify that updateAccount was called
        final captured = verify(() => mockAccountsDAO.updateAccount(captureAny())).captured;
        final capturedDTO = captured[0] as AccountDTO;
        expect(capturedDTO, updatedAccountDTO);
      });

      test(
          'returns [AccountsFailure] with [AccountsAction.updateAccountDetails] and correct [AccountsErrorType] when updating account is unsuccessful',
          () async {
        // Arrange
        when(() => mockAccountsDAO.updateAccount(any())).thenReturn(TaskEither.left(AccountsFailure.unknown(
          stackTrace: StackTrace.empty,
          message: AccountsErrorType.unknown.toString(),
          accountsAction: AccountsAction.updateAccountDetails,
        )));

        // Act
        final result = await accountsLocalDS.updateAccountDetails(updatedAccountDTO).run();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, AccountsAction.updateAccountDetails)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('deleteAccount()', () {
      final accountToDelete = AccountDTO(
        id: 'testId',
        creatorUid: 'testCreatorUid',
        name: 'testName',
        initialBalance: 0,
        balance: 0,
        currency: 'TST',
        createdOn: clock.now(),
        description: 'testDescription',
      );

      test('returns [Unit] when deleting account is successful', () async {
        // Arrange
        when(() => mockAccountsDAO.deleteAccount(any())).thenAnswer((_) async => 1);

        // Act
        final result = await accountsLocalDS.deleteAccount(accountToDelete).run();

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (l) => fail('Operation failed with error: $l'),
          (r) => expect(r, unit),
        );

        // Verify that deleteAccount was called
        final captured = verify(() => mockAccountsDAO.deleteAccount(captureAny())).captured;
        final capturedDTO = captured[0] as AccountDTO;
        expect(capturedDTO, accountToDelete);
      });

      test(
          'returns [AccountsFailure] with [AccountsAction.deleteAccount] and correct [AccountsErrorType] when deleting account is unsuccessful',
          () async {
        // Arrange
        when(() => mockAccountsDAO.deleteAccount(any())).thenThrow(Exception());

        // Act
        final result = await accountsLocalDS.deleteAccount(accountToDelete).run();

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, AccountsAction.deleteAccount)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });
  });
}
