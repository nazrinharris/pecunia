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
    );

Map<String, dynamic> _$$_PecuniaUserToJson(_$_PecuniaUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'dateCreated': instance.dateCreated.toIso8601String(),
    };
