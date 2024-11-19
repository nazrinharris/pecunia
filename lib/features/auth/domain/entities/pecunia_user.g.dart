// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pecunia_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PecuniaUserDTOImpl _$$PecuniaUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$PecuniaUserDTOImpl(
      uid: json['uid'] as String,
      username: json['username'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      userType: $enumDecode(_$UserTypeEnumMap, json['userType']),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$PecuniaUserDTOImplToJson(
        _$PecuniaUserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'email': instance.email,
    };

const _$UserTypeEnumMap = {
  UserType.remote: 'remote',
  UserType.local: 'local',
  UserType.guest: 'guest',
  UserType.unknown: 'unknown',
};
