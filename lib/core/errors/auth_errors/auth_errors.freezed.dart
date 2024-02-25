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
    TResult Function(StackTrace stackTrace, AuthErrorType errorType) $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)?
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
abstract class _$$AuthExceptionImplCopyWith<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  factory _$$AuthExceptionImplCopyWith(
          _$AuthExceptionImpl value, $Res Function(_$AuthExceptionImpl) then) =
      __$$AuthExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, AuthErrorType errorType});
}

/// @nodoc
class __$$AuthExceptionImplCopyWithImpl<$Res>
    extends _$AuthExceptionCopyWithImpl<$Res, _$AuthExceptionImpl>
    implements _$$AuthExceptionImplCopyWith<$Res> {
  __$$AuthExceptionImplCopyWithImpl(
      _$AuthExceptionImpl _value, $Res Function(_$AuthExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
  }) {
    return _then(_$AuthExceptionImpl(
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

class _$AuthExceptionImpl extends _AuthException {
  _$AuthExceptionImpl({required this.stackTrace, required this.errorType})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AuthErrorType errorType;

  @override
  String toString() {
    return 'AuthException(stackTrace: $stackTrace, errorType: $errorType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthExceptionImpl &&
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
  _$$AuthExceptionImplCopyWith<_$AuthExceptionImpl> get copyWith =>
      __$$AuthExceptionImplCopyWithImpl<_$AuthExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType) $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) {
    return $default(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) {
    return $default?.call(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)?
        $default, {
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, errorType);
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
      required final AuthErrorType errorType}) = _$AuthExceptionImpl;
  _AuthException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AuthErrorType get errorType;
  @override
  @JsonKey(ignore: true)
  _$$AuthExceptionImplCopyWith<_$AuthExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAuthExceptionImplCopyWith<$Res>
    implements $AuthExceptionCopyWith<$Res> {
  factory _$$UnknownAuthExceptionImplCopyWith(_$UnknownAuthExceptionImpl value,
          $Res Function(_$UnknownAuthExceptionImpl) then) =
      __$$UnknownAuthExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, AuthErrorType errorType});
}

/// @nodoc
class __$$UnknownAuthExceptionImplCopyWithImpl<$Res>
    extends _$AuthExceptionCopyWithImpl<$Res, _$UnknownAuthExceptionImpl>
    implements _$$UnknownAuthExceptionImplCopyWith<$Res> {
  __$$UnknownAuthExceptionImplCopyWithImpl(_$UnknownAuthExceptionImpl _value,
      $Res Function(_$UnknownAuthExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
  }) {
    return _then(_$UnknownAuthExceptionImpl(
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

class _$UnknownAuthExceptionImpl extends _UnknownAuthException {
  _$UnknownAuthExceptionImpl(
      {required this.stackTrace, this.errorType = AuthErrorType.unknown})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final AuthErrorType errorType;

  @override
  String toString() {
    return 'AuthException.unknown(stackTrace: $stackTrace, errorType: $errorType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownAuthExceptionImpl &&
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
  _$$UnknownAuthExceptionImplCopyWith<_$UnknownAuthExceptionImpl>
      get copyWith =>
          __$$UnknownAuthExceptionImplCopyWithImpl<_$UnknownAuthExceptionImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType) $default, {
    required TResult Function(StackTrace stackTrace, AuthErrorType errorType)
        unknown,
  }) {
    return unknown(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)?
        $default, {
    TResult? Function(StackTrace stackTrace, AuthErrorType errorType)? unknown,
  }) {
    return unknown?.call(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AuthErrorType errorType)?
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
      final AuthErrorType errorType}) = _$UnknownAuthExceptionImpl;
  _UnknownAuthException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AuthErrorType get errorType;
  @override
  @JsonKey(ignore: true)
  _$$UnknownAuthExceptionImplCopyWith<_$UnknownAuthExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AuthErrorType? get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        noInternet,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        unknown,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        incorrectCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
    required TResult Function(_IncorrectCredentialsAuthFailure value)
        incorrectCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
    TResult? Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    TResult Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
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
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
          _$AuthFailureImpl value, $Res Function(_$AuthFailureImpl) then) =
      __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
      _$AuthFailureImpl _value, $Res Function(_$AuthFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$AuthFailureImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$AuthFailureImpl extends _AuthFailure {
  const _$AuthFailureImpl(
      {required this.stackTrace,
      required this.message,
      required this.errorType,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  final AuthErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        noInternet,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        unknown,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        incorrectCredentials,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, message, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
    required TResult Function(_IncorrectCredentialsAuthFailure value)
        incorrectCredentials,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
    TResult? Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    TResult Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
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
      required final AuthErrorType errorType,
      final Object? rawException}) = _$AuthFailureImpl;
  const _AuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetAuthFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$NoInternetAuthFailureImplCopyWith(
          _$NoInternetAuthFailureImpl value,
          $Res Function(_$NoInternetAuthFailureImpl) then) =
      __$$NoInternetAuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$NoInternetAuthFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$NoInternetAuthFailureImpl>
    implements _$$NoInternetAuthFailureImplCopyWith<$Res> {
  __$$NoInternetAuthFailureImplCopyWithImpl(_$NoInternetAuthFailureImpl _value,
      $Res Function(_$NoInternetAuthFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$NoInternetAuthFailureImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$NoInternetAuthFailureImpl extends _NoInternetAuthFailure {
  const _$NoInternetAuthFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = AuthErrorType.noInternet,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final AuthErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoInternetAuthFailureImplCopyWith<_$NoInternetAuthFailureImpl>
      get copyWith => __$$NoInternetAuthFailureImplCopyWithImpl<
          _$NoInternetAuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        noInternet,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        unknown,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        incorrectCredentials,
  }) {
    return noInternet(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
  }) {
    return noInternet?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(stackTrace, message, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
    required TResult Function(_IncorrectCredentialsAuthFailure value)
        incorrectCredentials,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
    TResult? Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    TResult Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
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
      final AuthErrorType errorType,
      final Object? rawException}) = _$NoInternetAuthFailureImpl;
  const _NoInternetAuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$NoInternetAuthFailureImplCopyWith<_$NoInternetAuthFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAuthFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$UnknownAuthFailureImplCopyWith(_$UnknownAuthFailureImpl value,
          $Res Function(_$UnknownAuthFailureImpl) then) =
      __$$UnknownAuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthErrorType? errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownAuthFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$UnknownAuthFailureImpl>
    implements _$$UnknownAuthFailureImplCopyWith<$Res> {
  __$$UnknownAuthFailureImplCopyWithImpl(_$UnknownAuthFailureImpl _value,
      $Res Function(_$UnknownAuthFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = freezed,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownAuthFailureImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$UnknownAuthFailureImpl extends _UnknownAuthFailure {
  const _$UnknownAuthFailureImpl(
      {required this.stackTrace,
      this.message = defaultUnknownAuthErrorMessage,
      this.errorType = AuthErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final AuthErrorType? errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownAuthFailureImplCopyWith<_$UnknownAuthFailureImpl> get copyWith =>
      __$$UnknownAuthFailureImplCopyWithImpl<_$UnknownAuthFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        noInternet,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        unknown,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        incorrectCredentials,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(stackTrace, message, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
    required TResult Function(_IncorrectCredentialsAuthFailure value)
        incorrectCredentials,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
    TResult? Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    TResult Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
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
      final String message,
      final AuthErrorType? errorType,
      final Object? rawException}) = _$UnknownAuthFailureImpl;
  const _UnknownAuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthErrorType? get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$UnknownAuthFailureImplCopyWith<_$UnknownAuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IncorrectCredentialsAuthFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$IncorrectCredentialsAuthFailureImplCopyWith(
          _$IncorrectCredentialsAuthFailureImpl value,
          $Res Function(_$IncorrectCredentialsAuthFailureImpl) then) =
      __$$IncorrectCredentialsAuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AuthErrorType? errorType,
      Object? rawException});
}

/// @nodoc
class __$$IncorrectCredentialsAuthFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res,
        _$IncorrectCredentialsAuthFailureImpl>
    implements _$$IncorrectCredentialsAuthFailureImplCopyWith<$Res> {
  __$$IncorrectCredentialsAuthFailureImplCopyWithImpl(
      _$IncorrectCredentialsAuthFailureImpl _value,
      $Res Function(_$IncorrectCredentialsAuthFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = freezed,
    Object? rawException = freezed,
  }) {
    return _then(_$IncorrectCredentialsAuthFailureImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$IncorrectCredentialsAuthFailureImpl
    extends _IncorrectCredentialsAuthFailure {
  const _$IncorrectCredentialsAuthFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = AuthErrorType.incorrectCredentials,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final AuthErrorType? errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncorrectCredentialsAuthFailureImplCopyWith<
          _$IncorrectCredentialsAuthFailureImpl>
      get copyWith => __$$IncorrectCredentialsAuthFailureImplCopyWithImpl<
          _$IncorrectCredentialsAuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)
        noInternet,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        unknown,
    required TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)
        incorrectCredentials,
  }) {
    return incorrectCredentials(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult? Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
  }) {
    return incorrectCredentials?.call(
        stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType errorType, Object? rawException)?
        noInternet,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        unknown,
    TResult Function(StackTrace stackTrace, String message,
            AuthErrorType? errorType, Object? rawException)?
        incorrectCredentials,
    required TResult orElse(),
  }) {
    if (incorrectCredentials != null) {
      return incorrectCredentials(stackTrace, message, errorType, rawException);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthFailure value) $default, {
    required TResult Function(_NoInternetAuthFailure value) noInternet,
    required TResult Function(_UnknownAuthFailure value) unknown,
    required TResult Function(_IncorrectCredentialsAuthFailure value)
        incorrectCredentials,
  }) {
    return incorrectCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthFailure value)? $default, {
    TResult? Function(_NoInternetAuthFailure value)? noInternet,
    TResult? Function(_UnknownAuthFailure value)? unknown,
    TResult? Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
  }) {
    return incorrectCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthFailure value)? $default, {
    TResult Function(_NoInternetAuthFailure value)? noInternet,
    TResult Function(_UnknownAuthFailure value)? unknown,
    TResult Function(_IncorrectCredentialsAuthFailure value)?
        incorrectCredentials,
    required TResult orElse(),
  }) {
    if (incorrectCredentials != null) {
      return incorrectCredentials(this);
    }
    return orElse();
  }
}

abstract class _IncorrectCredentialsAuthFailure extends AuthFailure {
  const factory _IncorrectCredentialsAuthFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final AuthErrorType? errorType,
      final Object? rawException}) = _$IncorrectCredentialsAuthFailureImpl;
  const _IncorrectCredentialsAuthFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AuthErrorType? get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$IncorrectCredentialsAuthFailureImplCopyWith<
          _$IncorrectCredentialsAuthFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
