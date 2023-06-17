// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  AuthErrorType get errorType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)
        $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthException value) $default, {
    required TResult Function(_UnknownAuthException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthException value)? $default, {
    TResult? Function(_UnknownAuthException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthException value)? $default, {
    TResult Function(_UnknownAuthException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthExceptionCopyWith<AuthException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthExceptionCopyWith<$Res> {
  factory $AuthExceptionCopyWith(
          AuthException value, $Res Function(AuthException) then) =
      _$AuthExceptionCopyWithImpl<$Res, AuthException>;
  @useResult
  $Res call({StackTrace stackTrace, AuthErrorType errorType});
}

/// @nodoc
class _$AuthExceptionCopyWithImpl<$Res, $Val extends AuthException>
    implements $AuthExceptionCopyWith<$Res> {
  _$AuthExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthExceptionCopyWith<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  factory _$$_AuthExceptionCopyWith(
          _$_AuthException value, $Res Function(_$_AuthException) then) =
      __$$_AuthExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AuthErrorType errorType, AuthAction authAction});
}

/// @nodoc
class __$$_AuthExceptionCopyWithImpl<$Res>
    extends _$AuthExceptionCopyWithImpl<$Res, _$_AuthException>
    implements _$$_AuthExceptionCopyWith<$Res> {
  __$$_AuthExceptionCopyWithImpl(
      _$_AuthException _value, $Res Function(_$_AuthException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? authAction = null,
  }) {
    return _then(_$_AuthException(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
      authAction: null == authAction
          ? _value.authAction
          : authAction // ignore: cast_nullable_to_non_nullable
              as AuthAction,
    ));
  }
}

/// @nodoc

class _$_AuthException extends _AuthException {
  _$_AuthException(
      {required this.stackTrace,
      required this.errorType,
      required this.authAction})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AuthErrorType errorType;
  @override
  final AuthAction authAction;

  @override
  String toString() {
    return 'AuthException(stackTrace: $stackTrace, errorType: $errorType, authAction: $authAction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthException &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.authAction, authAction) ||
                other.authAction == authAction));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, stackTrace, errorType, authAction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthExceptionCopyWith<_$_AuthException> get copyWith =>
      __$$_AuthExceptionCopyWithImpl<_$_AuthException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)
        $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) {
    return $default(stackTrace, errorType, authAction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) {
    return $default?.call(stackTrace, errorType, authAction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, errorType, authAction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthException value) $default, {
    required TResult Function(_UnknownAuthException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthException value)? $default, {
    TResult? Function(_UnknownAuthException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthException value)? $default, {
    TResult Function(_UnknownAuthException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AuthException extends AuthException {
  factory _AuthException(
      {required final StackTrace stackTrace,
      required final AuthErrorType errorType,
      required final AuthAction authAction}) = _$_AuthException;
  _AuthException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AuthErrorType get errorType;
  AuthAction get authAction;
  @override
  @JsonKey(ignore: true)
  _$$_AuthExceptionCopyWith<_$_AuthException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownAuthExceptionCopyWith<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  factory _$$_UnknownAuthExceptionCopyWith(_$_UnknownAuthException value,
          $Res Function(_$_UnknownAuthException) then) =
      __$$_UnknownAuthExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, AuthErrorType errorType});
}

/// @nodoc
class __$$_UnknownAuthExceptionCopyWithImpl<$Res>
    extends _$AuthExceptionCopyWithImpl<$Res, _$_UnknownAuthException>
    implements _$$_UnknownAuthExceptionCopyWith<$Res> {
  __$$_UnknownAuthExceptionCopyWithImpl(_$_UnknownAuthException _value,
      $Res Function(_$_UnknownAuthException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
  }) {
    return _then(_$_UnknownAuthException(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
    ));
  }
}

/// @nodoc

class _$_UnknownAuthException extends _UnknownAuthException {
  _$_UnknownAuthException({required this.stackTrace, required this.errorType})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AuthErrorType errorType;

  @override
  String toString() {
    return 'AuthException.unknown(stackTrace: $stackTrace, errorType: $errorType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnknownAuthException &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownAuthExceptionCopyWith<_$_UnknownAuthException> get copyWith =>
      __$$_UnknownAuthExceptionCopyWithImpl<_$_UnknownAuthException>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)
        $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) {
    return unknown(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) {
    return unknown?.call(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType,
            AuthAction authAction)?
        $default, {
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(stackTrace, errorType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthException value) $default, {
    required TResult Function(_UnknownAuthException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthException value)? $default, {
    TResult? Function(_UnknownAuthException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthException value)? $default, {
    TResult Function(_UnknownAuthException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAuthException extends AuthException {
  factory _UnknownAuthException(
      {required final StackTrace stackTrace,
      required final AuthErrorType errorType}) = _$_UnknownAuthException;
  _UnknownAuthException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AuthErrorType get errorType;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownAuthExceptionCopyWith<_$_UnknownAuthException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AuthAction get authAction => throw _privateConstructorUsedError;
  AuthErrorType? get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        noInternet,
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthFailureCopyWith<AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res, AuthFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthAction authAction,
      AuthErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res, $Val extends AuthFailure>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? authAction = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authAction: null == authAction
          ? _value.authAction
          : authAction // ignore: cast_nullable_to_non_nullable
              as AuthAction,
      errorType: null == errorType
          ? _value.errorType!
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthFailureCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$_AuthFailureCopyWith(
          _$_AuthFailure value, $Res Function(_$_AuthFailure) then) =
      __$$_AuthFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthAction authAction,
      AuthErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_AuthFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$_AuthFailure>
    implements _$$_AuthFailureCopyWith<$Res> {
  __$$_AuthFailureCopyWithImpl(
      _$_AuthFailure _value, $Res Function(_$_AuthFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? authAction = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_AuthFailure(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authAction: null == authAction
          ? _value.authAction
          : authAction // ignore: cast_nullable_to_non_nullable
              as AuthAction,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$_AuthFailure extends _AuthFailure {
  const _$_AuthFailure(
      {required this.stackTrace,
      required this.message,
      required this.authAction,
      required this.errorType,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  final AuthAction authAction;
  @override
  final AuthErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthFailureCopyWith<_$_AuthFailure> get copyWith =>
      __$$_AuthFailureCopyWithImpl<_$_AuthFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        noInternet,
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
  }) {
    return $default?.call(
        stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, message, authAction, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AuthFailure extends AuthFailure {
  const factory _AuthFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final AuthAction authAction,
      required final AuthErrorType errorType,
      final Object? rawException}) = _$_AuthFailure;
  const _AuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthAction get authAction;
  @override
  AuthErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_AuthFailureCopyWith<_$_AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NoInternetAuthFailureCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$_NoInternetAuthFailureCopyWith(_$_NoInternetAuthFailure value,
          $Res Function(_$_NoInternetAuthFailure) then) =
      __$$_NoInternetAuthFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthAction authAction,
      AuthErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_NoInternetAuthFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$_NoInternetAuthFailure>
    implements _$$_NoInternetAuthFailureCopyWith<$Res> {
  __$$_NoInternetAuthFailureCopyWithImpl(_$_NoInternetAuthFailure _value,
      $Res Function(_$_NoInternetAuthFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? authAction = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_NoInternetAuthFailure(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authAction: null == authAction
          ? _value.authAction
          : authAction // ignore: cast_nullable_to_non_nullable
              as AuthAction,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$_NoInternetAuthFailure extends _NoInternetAuthFailure {
  const _$_NoInternetAuthFailure(
      {required this.stackTrace,
      required this.message,
      this.authAction = AuthAction.unknown,
      this.errorType = AuthErrorType.noInternet,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final AuthAction authAction;
  @override
  @JsonKey()
  final AuthErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoInternetAuthFailureCopyWith<_$_NoInternetAuthFailure> get copyWith =>
      __$$_NoInternetAuthFailureCopyWithImpl<_$_NoInternetAuthFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        noInternet,
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)
        unknown,
  }) {
    return noInternet(stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
  }) {
    return noInternet?.call(
        stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(
          stackTrace, message, authAction, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternetAuthFailure extends AuthFailure {
  const factory _NoInternetAuthFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final AuthAction authAction,
      final AuthErrorType errorType,
      final Object? rawException}) = _$_NoInternetAuthFailure;
  const _NoInternetAuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthAction get authAction;
  @override
  AuthErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_NoInternetAuthFailureCopyWith<_$_NoInternetAuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownAuthFailureCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$_UnknownAuthFailureCopyWith(_$_UnknownAuthFailure value,
          $Res Function(_$_UnknownAuthFailure) then) =
      __$$_UnknownAuthFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthAction authAction,
      AuthErrorType? errorType,
      Object? rawException});
}

/// @nodoc
class __$$_UnknownAuthFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$_UnknownAuthFailure>
    implements _$$_UnknownAuthFailureCopyWith<$Res> {
  __$$_UnknownAuthFailureCopyWithImpl(
      _$_UnknownAuthFailure _value, $Res Function(_$_UnknownAuthFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? authAction = null,
    Object? errorType = freezed,
    Object? rawException = freezed,
  }) {
    return _then(_$_UnknownAuthFailure(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      authAction: null == authAction
          ? _value.authAction
          : authAction // ignore: cast_nullable_to_non_nullable
              as AuthAction,
      errorType: freezed == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType?,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$_UnknownAuthFailure extends _UnknownAuthFailure {
  const _$_UnknownAuthFailure(
      {required this.stackTrace,
      required this.message,
      required this.authAction,
      this.errorType = AuthErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  final AuthAction authAction;
  @override
  @JsonKey()
  final AuthErrorType? errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownAuthFailureCopyWith<_$_UnknownAuthFailure> get copyWith =>
      __$$_UnknownAuthFailureCopyWithImpl<_$_UnknownAuthFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)
        noInternet,
    required TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult? Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
  }) {
    return unknown?.call(
        stackTrace, message, authAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType errorType,
            Object? rawException)?
        noInternet,
    TResult Function(
            StackTrace stackTrace,
            String message,
            AuthAction authAction,
            AuthErrorType? errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(stackTrace, message, authAction, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAuthFailure extends AuthFailure {
  const factory _UnknownAuthFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final AuthAction authAction,
      final AuthErrorType? errorType,
      final Object? rawException}) = _$_UnknownAuthFailure;
  const _UnknownAuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthAction get authAction;
  @override
  AuthErrorType? get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownAuthFailureCopyWith<_$_UnknownAuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
