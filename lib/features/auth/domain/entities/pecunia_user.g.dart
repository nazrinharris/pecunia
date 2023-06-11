// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pecunia_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PecuniaUser _$$_PecuniaUserFromJson(Map<String, dynamic> json) =>
    _$_PecuniaUser(
      uid: json['uid'] as String,
      username: json['username'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_PecuniaUserToJson(_$_PecuniaUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'email': instance.email,
    };

_$_PecuniaUserDTO _$$_PecuniaUserDTOFromJson(Map<String, dynamic> json) =>
    _$_PecuniaUserDTO(
      uid: json['uid'] as String,
      username: json['username'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_PecuniaUserDTOToJson(_$_PecuniaUserDTO instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'email': instance.email,
    };
