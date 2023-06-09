// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pecunia_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PecuniaUser _$PecuniaUserFromJson(Map<String, dynamic> json) {
  return _PecuniaUser.fromJson(json);
}

/// @nodoc
mixin _$PecuniaUser {
  String get uid => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PecuniaUserCopyWith<PecuniaUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PecuniaUserCopyWith<$Res> {
  factory $PecuniaUserCopyWith(
          PecuniaUser value, $Res Function(PecuniaUser) then) =
      _$PecuniaUserCopyWithImpl<$Res, PecuniaUser>;
  @useResult
  $Res call({String uid, String username, DateTime dateCreated, String? email});
}

/// @nodoc
class _$PecuniaUserCopyWithImpl<$Res, $Val extends PecuniaUser>
    implements $PecuniaUserCopyWith<$Res> {
  _$PecuniaUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? dateCreated = null,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PecuniaUserCopyWith<$Res>
    implements $PecuniaUserCopyWith<$Res> {
  factory _$$_PecuniaUserCopyWith(
          _$_PecuniaUser value, $Res Function(_$_PecuniaUser) then) =
      __$$_PecuniaUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String username, DateTime dateCreated, String? email});
}

/// @nodoc
class __$$_PecuniaUserCopyWithImpl<$Res>
    extends _$PecuniaUserCopyWithImpl<$Res, _$_PecuniaUser>
    implements _$$_PecuniaUserCopyWith<$Res> {
  __$$_PecuniaUserCopyWithImpl(
      _$_PecuniaUser _value, $Res Function(_$_PecuniaUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? dateCreated = null,
    Object? email = freezed,
  }) {
    return _then(_$_PecuniaUser(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PecuniaUser extends _PecuniaUser {
  _$_PecuniaUser(
      {required this.uid,
      required this.username,
      required this.dateCreated,
      this.email})
      : super._();

  factory _$_PecuniaUser.fromJson(Map<String, dynamic> json) =>
      _$$_PecuniaUserFromJson(json);

  @override
  final String uid;
  @override
  final String username;
  @override
  final DateTime dateCreated;
  @override
  final String? email;

  @override
  String toString() {
    return 'PecuniaUser(uid: $uid, username: $username, dateCreated: $dateCreated, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PecuniaUser &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, username, dateCreated, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PecuniaUserCopyWith<_$_PecuniaUser> get copyWith =>
      __$$_PecuniaUserCopyWithImpl<_$_PecuniaUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PecuniaUserToJson(
      this,
    );
  }
}

abstract class _PecuniaUser extends PecuniaUser {
  factory _PecuniaUser(
      {required final String uid,
      required final String username,
      required final DateTime dateCreated,
      final String? email}) = _$_PecuniaUser;
  _PecuniaUser._() : super._();

  factory _PecuniaUser.fromJson(Map<String, dynamic> json) =
      _$_PecuniaUser.fromJson;

  @override
  String get uid;
  @override
  String get username;
  @override
  DateTime get dateCreated;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$_PecuniaUserCopyWith<_$_PecuniaUser> get copyWith =>
      throw _privateConstructorUsedError;
}

PecuniaUserDTO _$PecuniaUserDTOFromJson(Map<String, dynamic> json) {
  return _PecuniaUserDTO.fromJson(json);
}

/// @nodoc
mixin _$PecuniaUserDTO {
  String get uid => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PecuniaUserDTOCopyWith<PecuniaUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PecuniaUserDTOCopyWith<$Res> {
  factory $PecuniaUserDTOCopyWith(
          PecuniaUserDTO value, $Res Function(PecuniaUserDTO) then) =
      _$PecuniaUserDTOCopyWithImpl<$Res, PecuniaUserDTO>;
  @useResult
  $Res call({String uid, String username, DateTime dateCreated, String? email});
}

/// @nodoc
class _$PecuniaUserDTOCopyWithImpl<$Res, $Val extends PecuniaUserDTO>
    implements $PecuniaUserDTOCopyWith<$Res> {
  _$PecuniaUserDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? dateCreated = null,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PecuniaUserDTOCopyWith<$Res>
    implements $PecuniaUserDTOCopyWith<$Res> {
  factory _$$_PecuniaUserDTOCopyWith(
          _$_PecuniaUserDTO value, $Res Function(_$_PecuniaUserDTO) then) =
      __$$_PecuniaUserDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String username, DateTime dateCreated, String? email});
}

/// @nodoc
class __$$_PecuniaUserDTOCopyWithImpl<$Res>
    extends _$PecuniaUserDTOCopyWithImpl<$Res, _$_PecuniaUserDTO>
    implements _$$_PecuniaUserDTOCopyWith<$Res> {
  __$$_PecuniaUserDTOCopyWithImpl(
      _$_PecuniaUserDTO _value, $Res Function(_$_PecuniaUserDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? dateCreated = null,
    Object? email = freezed,
  }) {
    return _then(_$_PecuniaUserDTO(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PecuniaUserDTO extends _PecuniaUserDTO {
  _$_PecuniaUserDTO(
      {required this.uid,
      required this.username,
      required this.dateCreated,
      this.email})
      : super._();

  factory _$_PecuniaUserDTO.fromJson(Map<String, dynamic> json) =>
      _$$_PecuniaUserDTOFromJson(json);

  @override
  final String uid;
  @override
  final String username;
  @override
  final DateTime dateCreated;
  @override
  final String? email;

  @override
  String toString() {
    return 'PecuniaUserDTO(uid: $uid, username: $username, dateCreated: $dateCreated, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PecuniaUserDTO &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, username, dateCreated, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PecuniaUserDTOCopyWith<_$_PecuniaUserDTO> get copyWith =>
      __$$_PecuniaUserDTOCopyWithImpl<_$_PecuniaUserDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PecuniaUserDTOToJson(
      this,
    );
  }
}

abstract class _PecuniaUserDTO extends PecuniaUserDTO {
  factory _PecuniaUserDTO(
      {required final String uid,
      required final String username,
      required final DateTime dateCreated,
      final String? email}) = _$_PecuniaUserDTO;
  _PecuniaUserDTO._() : super._();

  factory _PecuniaUserDTO.fromJson(Map<String, dynamic> json) =
      _$_PecuniaUserDTO.fromJson;

  @override
  String get uid;
  @override
  String get username;
  @override
  DateTime get dateCreated;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$$_PecuniaUserDTOCopyWith<_$_PecuniaUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
