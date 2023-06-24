import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:uuid/uuid.dart';

class MockUuid extends Mock implements Uuid {}

void main() {
  group('Account -', () {
    group('toDTO(), toJson(), fromDTO(), fromJson()', () {
      test('should create, serialize and deserialize correctly', () {
        // Arrange
        final clock = Clock.fixed(DateTime.utc(2023));
        const id = '1';
        const creatorUid = '12345';
        const name = 'Test Account';
        const initialBalance = 1000.0;
        const balance = 500.0;
        const currency = 'USD';
        final createdOn = clock.now();
        const description = 'Test Description';

        // Act
        final account = Account(
          id: id,
          creatorUid: creatorUid,
          name: name,
          initialBalance: initialBalance,
          balance: balance,
          currency: currency,
          createdOn: createdOn,
          description: AccountDescription(description),
        );

        // Assert
        expect(account.id, equals(id));
        expect(account.creatorUid, equals(creatorUid));
        expect(account.name, equals(name));
        expect(account.initialBalance, equals(initialBalance));
        expect(account.balance, equals(balance));
        expect(account.currency, equals(currency));
        expect(account.createdOn, equals(createdOn));
        expect(account.description.toString(), equals(description));

        // Serialize and Deserialize
        final dto = account.toDTO();
        final serializedAccount = dto.toJson();
        final deserializedDto = AccountDTO.fromJson(serializedAccount);
        final deserializedAccount = Account.fromDTO(deserializedDto);

        // Assert deserialized object
        expect(deserializedAccount.id, equals(id));
        expect(deserializedAccount.creatorUid, equals(creatorUid));
        expect(deserializedAccount.name, equals(name));
        expect(deserializedAccount.initialBalance, equals(initialBalance));
        expect(deserializedAccount.balance, equals(balance));
        expect(deserializedAccount.currency, equals(currency));
        expect(deserializedAccount.createdOn.toUtc().toIso8601String(), equals(createdOn.toIso8601String()));
        expect(deserializedAccount.description.toString(), equals(description));
      });
    });

    group('Account.newAccount()', () {
      test('should create a new account with the given arguments', () {
        // Arrange
        final mockU = MockUuid();
        final clock = Clock.fixed(DateTime.utc(2023));
        const name = 'Test Account';
        const currency = 'USD';

        when(mockU.v4).thenReturn('1');
        // Act
        final account = Account.newAccount(
          creatorUid: '12345',
          name: name,
          initialBalance: 0,
          currency: currency,
          createdOn: clock.now(),
          uuid: mockU,
          description: AccountDescription('testDescription'),
        );

        // Assert
        expect(account.id, '1');
        expect(account.creatorUid, equals('12345'));
        expect(account.name, equals(name));
        expect(account.initialBalance, equals(0.0));
        expect(account.balance, equals(0.0));
        expect(account.currency, equals(currency));
        expect(account.createdOn, equals(clock.now()));
        expect(account.description.toString(), equals('testDescription'));
      });
    });

    group('AccountDescription -', () {
      test('should treat null input as no description', () {
        final desc = AccountDescription(null);

        expect(desc.value, isNull);
        expect(desc.toString(), equals('No Description'));
      });

      test('should treat empty input as no description', () {
        final desc = AccountDescription('');

        expect(desc.value, isNull);
        expect(desc.toString(), equals('No Description'));
      });

      test('should treat whitespace-only input as no description', () {
        final desc = AccountDescription('   ');

        expect(desc.value, isNull);
        expect(desc.toString(), equals('No Description'));
      });

      test('should store non-empty, non-whitespace input', () {
        const input = 'Test Description';
        final desc = AccountDescription(input);

        expect(desc.value, equals(input));
        expect(desc.toString(), equals(input));
      });
    });
  });
}
