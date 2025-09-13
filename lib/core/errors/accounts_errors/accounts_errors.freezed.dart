// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountsFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AccountsErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccountsFailure value) $default, {
    required TResult Function(_UnknownAccountsFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsFailure value)? $default, {
    TResult? Function(_UnknownAccountsFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsFailure value)? $default, {
    TResult Function(_UnknownAccountsFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountsFailureCopyWith<AccountsFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountsFailureCopyWith<$Res> {
  factory $AccountsFailureCopyWith(
          AccountsFailure value, $Res Function(AccountsFailure) then) =
      _$AccountsFailureCopyWithImpl<$Res, AccountsFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AccountsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$AccountsFailureCopyWithImpl<$Res, $Val extends AccountsFailure>
    implements $AccountsFailureCopyWith<$Res> {
  _$AccountsFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
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
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AccountsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountsFailureImplCopyWith<$Res>
    implements $AccountsFailureCopyWith<$Res> {
  factory _$$AccountsFailureImplCopyWith(_$AccountsFailureImpl value,
          $Res Function(_$AccountsFailureImpl) then) =
      __$$AccountsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AccountsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$AccountsFailureImplCopyWithImpl<$Res>
    extends _$AccountsFailureCopyWithImpl<$Res, _$AccountsFailureImpl>
    implements _$$AccountsFailureImplCopyWith<$Res> {
  __$$AccountsFailureImplCopyWithImpl(
      _$AccountsFailureImpl _value, $Res Function(_$AccountsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$AccountsFailureImpl(
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
              as AccountsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$AccountsFailureImpl extends _AccountsFailure {
  const _$AccountsFailureImpl(
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
  final AccountsErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountsFailureImplCopyWith<_$AccountsFailureImpl> get copyWith =>
      __$$AccountsFailureImplCopyWithImpl<_$AccountsFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
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
    TResult Function(_AccountsFailure value) $default, {
    required TResult Function(_UnknownAccountsFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsFailure value)? $default, {
    TResult? Function(_UnknownAccountsFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsFailure value)? $default, {
    TResult Function(_UnknownAccountsFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AccountsFailure extends AccountsFailure {
  const factory _AccountsFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final AccountsErrorType errorType,
      final Object? rawException}) = _$AccountsFailureImpl;
  const _AccountsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AccountsErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountsFailureImplCopyWith<_$AccountsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAccountsFailureImplCopyWith<$Res>
    implements $AccountsFailureCopyWith<$Res> {
  factory _$$UnknownAccountsFailureImplCopyWith(
          _$UnknownAccountsFailureImpl value,
          $Res Function(_$UnknownAccountsFailureImpl) then) =
      __$$UnknownAccountsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AccountsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownAccountsFailureImplCopyWithImpl<$Res>
    extends _$AccountsFailureCopyWithImpl<$Res, _$UnknownAccountsFailureImpl>
    implements _$$UnknownAccountsFailureImplCopyWith<$Res> {
  __$$UnknownAccountsFailureImplCopyWithImpl(
      _$UnknownAccountsFailureImpl _value,
      $Res Function(_$UnknownAccountsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownAccountsFailureImpl(
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
              as AccountsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$UnknownAccountsFailureImpl extends _UnknownAccountsFailure {
  const _$UnknownAccountsFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = AccountsErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final AccountsErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownAccountsFailureImplCopyWith<_$UnknownAccountsFailureImpl>
      get copyWith => __$$UnknownAccountsFailureImplCopyWithImpl<
          _$UnknownAccountsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AccountsErrorType errorType, Object? rawException)?
        unknown,
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
    TResult Function(_AccountsFailure value) $default, {
    required TResult Function(_UnknownAccountsFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsFailure value)? $default, {
    TResult? Function(_UnknownAccountsFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsFailure value)? $default, {
    TResult Function(_UnknownAccountsFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAccountsFailure extends AccountsFailure {
  const factory _UnknownAccountsFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final AccountsErrorType errorType,
      final Object? rawException}) = _$UnknownAccountsFailureImpl;
  const _UnknownAccountsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AccountsErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of AccountsFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownAccountsFailureImplCopyWith<_$UnknownAccountsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AccountsException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  AccountsErrorType get errorType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccountsException value) $default, {
    required TResult Function(_UnknownAccountsException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsException value)? $default, {
    TResult? Function(_UnknownAccountsException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsException value)? $default, {
    TResult Function(_UnknownAccountsException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountsExceptionCopyWith<AccountsException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountsExceptionCopyWith<$Res> {
  factory $AccountsExceptionCopyWith(
          AccountsException value, $Res Function(AccountsException) then) =
      _$AccountsExceptionCopyWithImpl<$Res, AccountsException>;
  @useResult
  $Res call(
      {StackTrace stackTrace, AccountsErrorType errorType, String? message});
}

/// @nodoc
class _$AccountsExceptionCopyWithImpl<$Res, $Val extends AccountsException>
    implements $AccountsExceptionCopyWith<$Res> {
  _$AccountsExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AccountsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountsExceptionImplCopyWith<$Res>
    implements $AccountsExceptionCopyWith<$Res> {
  factory _$$AccountsExceptionImplCopyWith(_$AccountsExceptionImpl value,
          $Res Function(_$AccountsExceptionImpl) then) =
      __$$AccountsExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AccountsErrorType errorType, String? message});
}

/// @nodoc
class __$$AccountsExceptionImplCopyWithImpl<$Res>
    extends _$AccountsExceptionCopyWithImpl<$Res, _$AccountsExceptionImpl>
    implements _$$AccountsExceptionImplCopyWith<$Res> {
  __$$AccountsExceptionImplCopyWithImpl(_$AccountsExceptionImpl _value,
      $Res Function(_$AccountsExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$AccountsExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AccountsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AccountsExceptionImpl extends _AccountsException {
  _$AccountsExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AccountsErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'AccountsException(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountsExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountsExceptionImplCopyWith<_$AccountsExceptionImpl> get copyWith =>
      __$$AccountsExceptionImplCopyWithImpl<_$AccountsExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        unknown,
  }) {
    return $default(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, errorType, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccountsException value) $default, {
    required TResult Function(_UnknownAccountsException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsException value)? $default, {
    TResult? Function(_UnknownAccountsException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsException value)? $default, {
    TResult Function(_UnknownAccountsException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AccountsException extends AccountsException {
  factory _AccountsException(
      {required final StackTrace stackTrace,
      required final AccountsErrorType errorType,
      final String? message}) = _$AccountsExceptionImpl;
  _AccountsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AccountsErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountsExceptionImplCopyWith<_$AccountsExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAccountsExceptionImplCopyWith<$Res>
    implements $AccountsExceptionCopyWith<$Res> {
  factory _$$UnknownAccountsExceptionImplCopyWith(
          _$UnknownAccountsExceptionImpl value,
          $Res Function(_$UnknownAccountsExceptionImpl) then) =
      __$$UnknownAccountsExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AccountsErrorType errorType, String? message});
}

/// @nodoc
class __$$UnknownAccountsExceptionImplCopyWithImpl<$Res>
    extends _$AccountsExceptionCopyWithImpl<$Res,
        _$UnknownAccountsExceptionImpl>
    implements _$$UnknownAccountsExceptionImplCopyWith<$Res> {
  __$$UnknownAccountsExceptionImplCopyWithImpl(
      _$UnknownAccountsExceptionImpl _value,
      $Res Function(_$UnknownAccountsExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$UnknownAccountsExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AccountsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownAccountsExceptionImpl extends _UnknownAccountsException {
  _$UnknownAccountsExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AccountsErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'AccountsException.unknown(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownAccountsExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownAccountsExceptionImplCopyWith<_$UnknownAccountsExceptionImpl>
      get copyWith => __$$UnknownAccountsExceptionImplCopyWithImpl<
          _$UnknownAccountsExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AccountsErrorType errorType, String? message)
        unknown,
  }) {
    return unknown(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, AccountsErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(stackTrace, errorType, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccountsException value) $default, {
    required TResult Function(_UnknownAccountsException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountsException value)? $default, {
    TResult? Function(_UnknownAccountsException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountsException value)? $default, {
    TResult Function(_UnknownAccountsException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAccountsException extends AccountsException {
  factory _UnknownAccountsException(
      {required final StackTrace stackTrace,
      required final AccountsErrorType errorType,
      final String? message}) = _$UnknownAccountsExceptionImpl;
  _UnknownAccountsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AccountsErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of AccountsException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownAccountsExceptionImplCopyWith<_$UnknownAccountsExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
