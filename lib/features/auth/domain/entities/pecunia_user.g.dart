// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pecunia_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PecuniaUserImpl _$$PecuniaUserImplFromJson(Map<String, dynamic> json) =>
    _$PecuniaUserImpl(
      uid: json['uid'] as String,
      username: json['username'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$PecuniaUserImplToJson(_$PecuniaUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'email': instance.email,
    };

_$PecuniaUserDTOImpl _$$PecuniaUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$PecuniaUserDTOImpl(
      uid: json['uid'] as String,
      username: json['username'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$PecuniaUserDTOImplToJson(
        _$PecuniaUserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'email': instance.email,
    };
