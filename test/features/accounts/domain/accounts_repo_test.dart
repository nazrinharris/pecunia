import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/data/accounts_local_ds.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:uuid/uuid.dart';

import '../../../matcher/accounts_matchers.dart';

class MockAccountsLocalDS extends Mock implements AccountsLocalDS {}

class MockAccountsRepoHelper extends Mock implements AccountsRepoHelper {}

class MockAccountDescription extends Mock implements AccountDescription {}

class MockAccount extends Mock implements Account {}

class MockUuid extends Mock implements Uuid {}

void main() {
  late AccountsRepoImpl accountsRepo;
  late AccountsRepoHelper accountsRepoHelper;

  late MockAccountsLocalDS mockAccountsLocalDS;
  late MockAccountsRepoHelper mockAccountsRepoHelper;
  late MockAccountDescription mockAccountDescription;
  late MockAccount mockAccount;
  late MockUuid mockUuid;

  late Account testAccount;
  late AccountDTO testAccountDTO;
  late List<AccountDTO> testAccountsDTOList;

  setUpAll(() {
    final clock = Clock.fixed(DateTime.utc(2023));

    // Setup mocks
    mockAccountsLocalDS = MockAccountsLocalDS();
    mockAccountsRepoHelper = MockAccountsRepoHelper();
    mockAccountDescription = MockAccountDescription();
    mockAccount = MockAccount();
    mockUuid = MockUuid();

    // Setup repo and helper
    accountsRepo = AccountsRepoImpl(
      accountsLocalDS: mockAccountsLocalDS,
      helper: mockAccountsRepoHelper,
      uuid: mockUuid,
    );
    accountsRepoHelper = AccountsRepoHelper();

    // Setup test data
    testAccount = Account(
      id: 'testId',
      creatorUid: 'testCreatorUid',
      name: 'testName',
      initialBalance: 0,
      balance: 0,
      currency: 'TST',
      createdOn: clock.now(),
      description: mockAccountDescription,
    );

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

    testAccountsDTOList = [testAccountDTO];

    // Register fallback values
    registerFallbackValue(testAccountDTO);
    registerFallbackValue(testAccount);

    // Mock AccountsRepoHelper, we expect this to succeed everytime.
    when(() => mockAccountsRepoHelper.mapAccountToDTO(any()))
        .thenAnswer((_) => TaskEither.right(testAccountDTO));

    // Mock Desc
    when(() => mockAccountDescription.value).thenReturn('testDescription');

    // Mock Uuid
    when(() => mockUuid.v4()).thenReturn('testId');
  });

  group('AccountsRepoImpl -', () {
    group('getAccounts()', () {
      const currentAction = AccountsAction.getAccounts;
      test('returns a [List<Account>] when the call to accountsLocalDS is successful', () async {
        // Arrange
        when(() => mockAccountsLocalDS.getAccounts()).thenAnswer(
          (_) => TaskEither.right(testAccountsDTOList),
        );

        // Act
        final result = await accountsRepo.getAccounts().run();

        // Assert
        expect(result.isRight(), true);
        expect(result.getOrElse((_) => []), isA<List<Account>>());
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.getAccounts] and correct [AccountsErrorType] when the call to accountsLocalDS is unsuccessful',
          () async {
        // Arrange
        when(() => mockAccountsLocalDS.getAccounts()).thenAnswer(
          (_) => TaskEither.left(AccountsFailure.unknown(
            stackTrace: StackTrace.current,
            message: AccountsErrorType.unknown.message,
            accountsAction: currentAction,
          )),
        );

        // Act
        final result = await accountsRepo.getAccounts().run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, currentAction)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('watchAccounts()', () {
      test(
          'returns a [Stream<Either<AccountsFailure, List<Account>>>] when the call to accountsLocalDS is successful',
          () async {
        // Arrange
        when(() => mockAccountsLocalDS.watchAccounts()).thenAnswer(
          (_) => Stream.value(
            right(testAccountsDTOList),
          ),
        );

        // Act
        final result = accountsRepo.watchAccounts();

        // Assert
        expect(result, isA<Stream<Either<AccountsFailure, List<Account>>>>());
      });

      test(
          'returns a [Stream<Either<AccountsFailure, List<Account>>>] when the call to accountsLocalDS is unsuccessful',
          () async {
        // Arrange
        when(() => mockAccountsLocalDS.watchAccounts()).thenAnswer(
          (_) => Stream.value(
            left(AccountsFailure.unknown(
              stackTrace: StackTrace.current,
              message: AccountsErrorType.unknown.message,
              accountsAction: AccountsAction.watchAccounts,
            )),
          ),
        );

        // Act
        final result = accountsRepo.watchAccounts();

        // Assert
        expect(result, isA<Stream<Either<AccountsFailure, List<Account>>>>());
      });
    });

    group('createAccount()', () {
      test('returns a [Unit] when the call to accountsLocalDS is successful', () async {
        // Arrange
        when(
          () => mockAccountsLocalDS.createAccount(any<AccountDTO>()),
        ).thenAnswer((_) => TaskEither.right(unit));

        // Act
        final result = await accountsRepo
            .createAccount(
              name: 'testName',
              creatorUid: 'testCreatorUid',
              initialBalance: 0,
              currency: 'TST',
              desc: 'testDesc',
            )
            .run();

        // Assert
        expect(result.isRight(), true);
        expect(result.getOrElse((_) => unit), unit);
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.createAccount] and correct [AccountsErrorType] when the call to accountsLocalDS is unsuccessful',
          () async {
        // Arrange
        when(
          () => mockAccountsLocalDS.createAccount(any<AccountDTO>()),
        ).thenAnswer((_) => TaskEither.left(AccountsFailure.unknown(
              stackTrace: StackTrace.current,
              message: AccountsErrorType.unknown.message,
              accountsAction: AccountsAction.createAccount,
            )));

        // Act
        final result = await accountsRepo
            .createAccount(
              name: 'testName',
              creatorUid: 'testCreatorUid',
              initialBalance: 0,
              currency: 'TST',
              desc: 'testDesc',
            )
            .run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, AccountsAction.createAccount)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('updateAccount()', () {
      test('returns a [Unit] when the call to accountsLocalDS is successful', () async {
        // Arrange
        when(
          () => mockAccountsLocalDS.updateAccountDetails(any()),
        ).thenAnswer((_) => TaskEither.right(unit));

        // Act
        final result = await accountsRepo.updateAccountDetails(testAccount).run();

        // Assert
        expect(result.isRight(), true);
        expect(result.getOrElse((_) => unit), unit);
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.updateAccount] and correct [AccountsErrorType] when the call to accountsLocalDS is unsuccessful',
          () async {
        // Arrange
        const currentAction = AccountsAction.updateAccountDetails;
        when(
          () => mockAccountsLocalDS.updateAccountDetails(any()),
        ).thenAnswer((_) => TaskEither.left(AccountsFailure.unknown(
              stackTrace: StackTrace.current,
              message: AccountsErrorType.unknown.message,
              accountsAction: currentAction,
            )));

        // Act
        final result = await accountsRepo.updateAccountDetails(testAccount).run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, currentAction)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });

    group('deleteAccount()', () {
      test('returns a [Unit] when the call to accountsLocalDS is successful', () async {
        // Arrange
        when(
          () => mockAccountsLocalDS.deleteAccount(any()),
        ).thenAnswer((_) => TaskEither.right(unit));

        // Act
        final result = await accountsRepo.deleteAccount(testAccount).run();

        // Assert
        expect(result.isRight(), true);
        expect(result.getOrElse((_) => unit), unit);
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.deleteAccount] and correct [AccountsErrorType] when the call to accountsLocalDS is unsuccessful',
          () async {
        // Arrange
        const currentAction = AccountsAction.deleteAccount;
        when(
          () => mockAccountsLocalDS.deleteAccount(any()),
        ).thenAnswer((_) => TaskEither.left(AccountsFailure.unknown(
              stackTrace: StackTrace.current,
              message: AccountsErrorType.unknown.message,
              accountsAction: currentAction,
            )));

        // Act
        final result = await accountsRepo.deleteAccount(testAccount).run();

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.unknown, currentAction)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });
  });

  group('AccountsRepoHelper -', () {
    group('mapAccountToDTO()', () {
      test('returns an [AccountDTO] when conversion is successfull', () async {
        // Arrange
        when(() => mockAccount.toDTO()).thenReturn(testAccountDTO);

        // Act
        final result = await accountsRepoHelper.mapAccountToDTO(mockAccount).run();

        // Assert
        result.fold(
          (l) => fail('Operation failed with value: $l'),
          (r) => expect(r, testAccountDTO),
        );
      });

      test(
          'returns an [AccountsFailure] with [AccountsAction.mapAccountToDTO] and correct [AccountsErrorType] when conversion is unsuccessfull',
          () async {
        // Arrange
        const currentAction = AccountsAction.mapAccountToDTO;
        when(() => mockAccount.toDTO()).thenThrow(Exception());

        // Act
        final result = await accountsRepoHelper.mapAccountToDTO(mockAccount).run();

        // Assert

        result.fold(
          (l) => expect(l, isAccountsFailure(AccountsErrorType.cannotConvertToDTO, currentAction)),
          (r) => fail('Operation succeeded with value: $r'),
        );
      });
    });
  });
}
