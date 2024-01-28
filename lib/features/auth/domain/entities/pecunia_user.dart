import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pecunia_user.freezed.dart';
part 'pecunia_user.g.dart';

enum UserType {
  remote('remote'),
  local('local'),
  unknown('unknown');

  const UserType(this.typeAsString);

  final String typeAsString;

  static UserType fromString(String typeAsString) {
    return UserType.values.firstWhere(
      (element) => element.typeAsString == typeAsString,
      orElse: () => UserType.unknown,
    );
  }
}

@freezed
class PecuniaUser with _$PecuniaUser {
  factory PecuniaUser({
    required String uid,
    required String username,
    required DateTime dateCreated,
    required UserType userType,
    required String? email,
  }) = _PecuniaUser;

  const PecuniaUser._();

  factory PecuniaUser.empty() => PecuniaUser(
        uid: '',
        username: '',
        dateCreated: DateTime.now(),
        email: '',
        userType: UserType.unknown,
      );

  factory PecuniaUser.fromDTO(PecuniaUserDTO dto) {
    return PecuniaUser(
      uid: dto.uid,
      username: dto.username,
      dateCreated: dto.dateCreated,
      email: dto.email,
      userType: dto.userType,
    );
  }

  PecuniaUserDTO toDTO() {
    return PecuniaUserDTO(
      uid: uid,
      username: username,
      dateCreated: dateCreated,
      email: email,
      userType: userType,
    );
  }
}

@Freezed(fromJson: true, toJson: true)
class PecuniaUserDTO with _$PecuniaUserDTO {
  factory PecuniaUserDTO({
    required String uid,
    required String username,
    required DateTime dateCreated,
    required UserType userType,
    required String? email,
  }) = _PecuniaUserDTO;

  const PecuniaUserDTO._();

  factory PecuniaUserDTO.fromDomain(PecuniaUser user) {
    return PecuniaUserDTO(
      uid: user.uid,
      username: user.username,
      dateCreated: user.dateCreated,
      email: user.email,
      userType: user.userType,
    );
  }

  factory PecuniaUserDTO.fromJson(Map<String, dynamic> json) {
    debugPrint('PecuniaUserDTO.fromJson: $json');
    if (json['userType'] == null) {
      return PecuniaUserDTO(
        uid: json['uid'] as String,
        email: json['email'] as String?,
        username: json['username'] as String,
        dateCreated: DateTime.parse(json['dateCreated'] as String),
        userType: UserType.unknown,
      );
    } else {
      return _$PecuniaUserDTOFromJson(json);
    }
  }

  PecuniaUser toDomain() {
    return PecuniaUser(
      uid: uid,
      username: username,
      dateCreated: dateCreated,
      email: email,
      userType: userType,
    );
  }
}
