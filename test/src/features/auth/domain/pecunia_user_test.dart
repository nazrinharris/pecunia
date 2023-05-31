// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:pecunia/src/features/auth/domain/pecunia_user.dart';

void main() {
  group('PecuniaUser', () {
    test('should create, serialize and deserialize correctly', () {
      // Arrange
      final uid = '12345';
      final username = 'test_user';
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
      final jsonDecoded = jsonDecode(jsonEncoded);
      final deserializedPecuniaUser = PecuniaUser.fromJson(jsonDecoded);

      // Assert deserialized object
      expect(deserializedPecuniaUser.uid, equals(uid));
      expect(deserializedPecuniaUser.username, equals(username));
      expect(deserializedPecuniaUser.dateCreated.toIso8601String(),
          equals(dateCreated.toIso8601String()));
    });
  });
}
