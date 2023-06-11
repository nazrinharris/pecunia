import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';

void main() {
  group('PecuniaUser -', () {
    test('should create, serialize and deserialize correctly', () {
      // Arrange
      const uid = '12345';
      const username = 'test_user';
      final dateCreated = DateTime.now();

      // Act
      final pecuniaUser = PecuniaUser(
        uid: uid,
        username: username,
        dateCreated: dateCreated,
      );

      // Assert
      expect(pecuniaUser.uid, equals(uid));
      expect(pecuniaUser.username, equals(username));
      expect(pecuniaUser.dateCreated, equals(dateCreated));

      // Serialize and Deserialize
      final jsonEncoded = jsonEncode(pecuniaUser.toJson());
      final jsonDecoded = jsonDecode(jsonEncoded) as Map<String, dynamic>;
      final deserializedPecuniaUser = PecuniaUser.fromJson(jsonDecoded);

      // Assert deserialized object
      expect(deserializedPecuniaUser.uid, equals(uid));
      expect(deserializedPecuniaUser.username, equals(username));
      expect(deserializedPecuniaUser.dateCreated.toIso8601String(), equals(dateCreated.toIso8601String()));
    });
  });

  group('PecuniaUserDTO -', () {
    test('should create and fromDomain and toDomain correctly', () {
      final dateCreated = DateTime.now();

      // Create a PecuniaUser
      final user = PecuniaUser(
        uid: '1',
        username: 'Test User',
        dateCreated: dateCreated,
      );

      // Convert the PecuniaUser to a PecuniaUserDTO
      final dto = PecuniaUserDTO.fromDomain(user);

      // Assert that the DTO has the same properties as the original user
      expect(dto.uid, '1');
      expect(dto.username, 'Test User');
      expect(dto.dateCreated, dateCreated);

      // Convert the DTO back to a PecuniaUser
      final userFromDto = dto.toDomain();

      // Assert that the user created from the DTO has the same properties as the original user
      expect(userFromDto.uid, '1');
      expect(userFromDto.username, 'Test User');
      expect(userFromDto.dateCreated, dateCreated);
    });

    test('should create, serialize and deserialize correctly', () {
      final testDate = DateTime.now();

      // Create a PecuniaUserDTO
      final dto = PecuniaUserDTO(
        uid: '1',
        username: 'Test User',
        dateCreated: testDate,
      );

      // Serialize to JSON
      final json = dto.toJson();

      // Assert that JSON has correct values
      expect(json['uid'], '1');
      expect(json['username'], 'Test User');
      expect(json['dateCreated'], testDate.toIso8601String());

      // Deserialize from JSON
      final dtoFromJson = PecuniaUserDTO.fromJson(json);

      // Assert that deserialized DTO is equivalent to original
      expect(dtoFromJson.uid, '1');
      expect(dtoFromJson.username, 'Test User');
      expect(dtoFromJson.dateCreated, testDate);
    });
  });
}
