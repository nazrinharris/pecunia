// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Session {
  String get uid => throw _privateConstructorUsedError;
  JWT get jwt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid, JWT jwt) local,
    required TResult Function(String uid, JWT jwt) remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid, JWT jwt)? local,
    TResult? Function(String uid, JWT jwt)? remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid, JWT jwt)? local,
    TResult Function(String uid, JWT jwt)? remote,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocalSession value) local,
    required TResult Function(RemoteSession value) remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocalSession value)? local,
    TResult? Function(RemoteSession value)? remote,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocalSession value)? local,
    TResult Function(RemoteSession value)? remote,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({String uid, JWT jwt});
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? jwt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as JWT,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalSessionImplCopyWith<$Res>
    implements $SessionCopyWith<$Res> {
  factory _$$LocalSessionImplCopyWith(
          _$LocalSessionImpl value, $Res Function(_$LocalSessionImpl) then) =
      __$$LocalSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, JWT jwt});
}

/// @nodoc
class __$$LocalSessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$LocalSessionImpl>
    implements _$$LocalSessionImplCopyWith<$Res> {
  __$$LocalSessionImplCopyWithImpl(
      _$LocalSessionImpl _value, $Res Function(_$LocalSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? jwt = null,
  }) {
    return _then(_$LocalSessionImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as JWT,
    ));
  }
}

/// @nodoc

class _$LocalSessionImpl extends LocalSession {
  _$LocalSessionImpl({required this.uid, required this.jwt}) : super._();

  @override
  final String uid;
  @override
  final JWT jwt;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalSessionImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, jwt);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalSessionImplCopyWith<_$LocalSessionImpl> get copyWith =>
      __$$LocalSessionImplCopyWithImpl<_$LocalSessionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid, JWT jwt) local,
    required TResult Function(String uid, JWT jwt) remote,
  }) {
    return local(uid, jwt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid, JWT jwt)? local,
    TResult? Function(String uid, JWT jwt)? remote,
  }) {
    return local?.call(uid, jwt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid, JWT jwt)? local,
    TResult Function(String uid, JWT jwt)? remote,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(uid, jwt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocalSession value) local,
    required TResult Function(RemoteSession value) remote,
  }) {
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocalSession value)? local,
    TResult? Function(RemoteSession value)? remote,
  }) {
    return local?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocalSession value)? local,
    TResult Function(RemoteSession value)? remote,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(this);
    }
    return orElse();
  }
}

abstract class LocalSession extends Session {
  factory LocalSession({required final String uid, required final JWT jwt}) =
      _$LocalSessionImpl;
  LocalSession._() : super._();

  @override
  String get uid;
  @override
  JWT get jwt;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalSessionImplCopyWith<_$LocalSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoteSessionImplCopyWith<$Res>
    implements $SessionCopyWith<$Res> {
  factory _$$RemoteSessionImplCopyWith(
          _$RemoteSessionImpl value, $Res Function(_$RemoteSessionImpl) then) =
      __$$RemoteSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, JWT jwt});
}

/// @nodoc
class __$$RemoteSessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$RemoteSessionImpl>
    implements _$$RemoteSessionImplCopyWith<$Res> {
  __$$RemoteSessionImplCopyWithImpl(
      _$RemoteSessionImpl _value, $Res Function(_$RemoteSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? jwt = null,
  }) {
    return _then(_$RemoteSessionImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as JWT,
    ));
  }
}

/// @nodoc

class _$RemoteSessionImpl extends RemoteSession {
  _$RemoteSessionImpl({required this.uid, required this.jwt}) : super._();

  @override
  final String uid;
  @override
  final JWT jwt;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteSessionImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, jwt);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteSessionImplCopyWith<_$RemoteSessionImpl> get copyWith =>
      __$$RemoteSessionImplCopyWithImpl<_$RemoteSessionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String uid, JWT jwt) local,
    required TResult Function(String uid, JWT jwt) remote,
  }) {
    return remote(uid, jwt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String uid, JWT jwt)? local,
    TResult? Function(String uid, JWT jwt)? remote,
  }) {
    return remote?.call(uid, jwt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String uid, JWT jwt)? local,
    TResult Function(String uid, JWT jwt)? remote,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(uid, jwt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LocalSession value) local,
    required TResult Function(RemoteSession value) remote,
  }) {
    return remote(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LocalSession value)? local,
    TResult? Function(RemoteSession value)? remote,
  }) {
    return remote?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LocalSession value)? local,
    TResult Function(RemoteSession value)? remote,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(this);
    }
    return orElse();
  }
}

abstract class RemoteSession extends Session {
  factory RemoteSession({required final String uid, required final JWT jwt}) =
      _$RemoteSessionImpl;
  RemoteSession._() : super._();

  @override
  String get uid;
  @override
  JWT get jwt;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoteSessionImplCopyWith<_$RemoteSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
