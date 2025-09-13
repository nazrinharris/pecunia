// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionsException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  TransactionsErrorType get errorType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TransactionsErrorType errorType, String? message)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TransactionsException value) $default, {
    required TResult Function(_UnknownTransactionsException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsException value)? $default, {
    TResult? Function(_UnknownTransactionsException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsException value)? $default, {
    TResult Function(_UnknownTransactionsException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionsExceptionCopyWith<TransactionsException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsExceptionCopyWith<$Res> {
  factory $TransactionsExceptionCopyWith(TransactionsException value,
          $Res Function(TransactionsException) then) =
      _$TransactionsExceptionCopyWithImpl<$Res, TransactionsException>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TransactionsErrorType errorType,
      String? message});
}

/// @nodoc
class _$TransactionsExceptionCopyWithImpl<$Res,
        $Val extends TransactionsException>
    implements $TransactionsExceptionCopyWith<$Res> {
  _$TransactionsExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsException
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
              as TransactionsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionsExceptionImplCopyWith<$Res>
    implements $TransactionsExceptionCopyWith<$Res> {
  factory _$$TransactionsExceptionImplCopyWith(
          _$TransactionsExceptionImpl value,
          $Res Function(_$TransactionsExceptionImpl) then) =
      __$$TransactionsExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TransactionsErrorType errorType,
      String? message});
}

/// @nodoc
class __$$TransactionsExceptionImplCopyWithImpl<$Res>
    extends _$TransactionsExceptionCopyWithImpl<$Res,
        _$TransactionsExceptionImpl>
    implements _$$TransactionsExceptionImplCopyWith<$Res> {
  __$$TransactionsExceptionImplCopyWithImpl(_$TransactionsExceptionImpl _value,
      $Res Function(_$TransactionsExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$TransactionsExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TransactionsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TransactionsExceptionImpl extends _TransactionsException {
  _$TransactionsExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final TransactionsErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'TransactionsException(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsExceptionImplCopyWith<_$TransactionsExceptionImpl>
      get copyWith => __$$TransactionsExceptionImplCopyWithImpl<
          _$TransactionsExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TransactionsErrorType errorType, String? message)
        unknown,
  }) {
    return $default(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
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
    TResult Function(_TransactionsException value) $default, {
    required TResult Function(_UnknownTransactionsException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsException value)? $default, {
    TResult? Function(_UnknownTransactionsException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsException value)? $default, {
    TResult Function(_UnknownTransactionsException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _TransactionsException extends TransactionsException {
  factory _TransactionsException(
      {required final StackTrace stackTrace,
      required final TransactionsErrorType errorType,
      final String? message}) = _$TransactionsExceptionImpl;
  _TransactionsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  TransactionsErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsExceptionImplCopyWith<_$TransactionsExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownTransactionsExceptionImplCopyWith<$Res>
    implements $TransactionsExceptionCopyWith<$Res> {
  factory _$$UnknownTransactionsExceptionImplCopyWith(
          _$UnknownTransactionsExceptionImpl value,
          $Res Function(_$UnknownTransactionsExceptionImpl) then) =
      __$$UnknownTransactionsExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TransactionsErrorType errorType,
      String? message});
}

/// @nodoc
class __$$UnknownTransactionsExceptionImplCopyWithImpl<$Res>
    extends _$TransactionsExceptionCopyWithImpl<$Res,
        _$UnknownTransactionsExceptionImpl>
    implements _$$UnknownTransactionsExceptionImplCopyWith<$Res> {
  __$$UnknownTransactionsExceptionImplCopyWithImpl(
      _$UnknownTransactionsExceptionImpl _value,
      $Res Function(_$UnknownTransactionsExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$UnknownTransactionsExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TransactionsErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownTransactionsExceptionImpl extends _UnknownTransactionsException {
  _$UnknownTransactionsExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final TransactionsErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'TransactionsException.unknown(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownTransactionsExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownTransactionsExceptionImplCopyWith<
          _$UnknownTransactionsExceptionImpl>
      get copyWith => __$$UnknownTransactionsExceptionImplCopyWithImpl<
          _$UnknownTransactionsExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TransactionsErrorType errorType, String? message)
        unknown,
  }) {
    return unknown(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
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
    TResult Function(_TransactionsException value) $default, {
    required TResult Function(_UnknownTransactionsException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsException value)? $default, {
    TResult? Function(_UnknownTransactionsException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsException value)? $default, {
    TResult Function(_UnknownTransactionsException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownTransactionsException extends TransactionsException {
  factory _UnknownTransactionsException(
      {required final StackTrace stackTrace,
      required final TransactionsErrorType errorType,
      final String? message}) = _$UnknownTransactionsExceptionImpl;
  _UnknownTransactionsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  TransactionsErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of TransactionsException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownTransactionsExceptionImplCopyWith<
          _$UnknownTransactionsExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionsFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  TransactionsErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TransactionsFailure value) $default, {
    required TResult Function(_UnknownTransactionsFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsFailure value)? $default, {
    TResult? Function(_UnknownTransactionsFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsFailure value)? $default, {
    TResult Function(_UnknownTransactionsFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionsFailureCopyWith<TransactionsFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsFailureCopyWith<$Res> {
  factory $TransactionsFailureCopyWith(
          TransactionsFailure value, $Res Function(TransactionsFailure) then) =
      _$TransactionsFailureCopyWithImpl<$Res, TransactionsFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TransactionsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$TransactionsFailureCopyWithImpl<$Res, $Val extends TransactionsFailure>
    implements $TransactionsFailureCopyWith<$Res> {
  _$TransactionsFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsFailure
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
              as TransactionsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionsFailureImplCopyWith<$Res>
    implements $TransactionsFailureCopyWith<$Res> {
  factory _$$TransactionsFailureImplCopyWith(_$TransactionsFailureImpl value,
          $Res Function(_$TransactionsFailureImpl) then) =
      __$$TransactionsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TransactionsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$TransactionsFailureImplCopyWithImpl<$Res>
    extends _$TransactionsFailureCopyWithImpl<$Res, _$TransactionsFailureImpl>
    implements _$$TransactionsFailureImplCopyWith<$Res> {
  __$$TransactionsFailureImplCopyWithImpl(_$TransactionsFailureImpl _value,
      $Res Function(_$TransactionsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$TransactionsFailureImpl(
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
              as TransactionsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$TransactionsFailureImpl extends _TransactionsFailure {
  const _$TransactionsFailureImpl(
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
  final TransactionsErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsFailureImplCopyWith<_$TransactionsFailureImpl> get copyWith =>
      __$$TransactionsFailureImplCopyWithImpl<_$TransactionsFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
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
    TResult Function(_TransactionsFailure value) $default, {
    required TResult Function(_UnknownTransactionsFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsFailure value)? $default, {
    TResult? Function(_UnknownTransactionsFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsFailure value)? $default, {
    TResult Function(_UnknownTransactionsFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _TransactionsFailure extends TransactionsFailure {
  const factory _TransactionsFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final TransactionsErrorType errorType,
      final Object? rawException}) = _$TransactionsFailureImpl;
  const _TransactionsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TransactionsErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsFailureImplCopyWith<_$TransactionsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownTransactionsFailureImplCopyWith<$Res>
    implements $TransactionsFailureCopyWith<$Res> {
  factory _$$UnknownTransactionsFailureImplCopyWith(
          _$UnknownTransactionsFailureImpl value,
          $Res Function(_$UnknownTransactionsFailureImpl) then) =
      __$$UnknownTransactionsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TransactionsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownTransactionsFailureImplCopyWithImpl<$Res>
    extends _$TransactionsFailureCopyWithImpl<$Res,
        _$UnknownTransactionsFailureImpl>
    implements _$$UnknownTransactionsFailureImplCopyWith<$Res> {
  __$$UnknownTransactionsFailureImplCopyWithImpl(
      _$UnknownTransactionsFailureImpl _value,
      $Res Function(_$UnknownTransactionsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownTransactionsFailureImpl(
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
              as TransactionsErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$UnknownTransactionsFailureImpl extends _UnknownTransactionsFailure {
  const _$UnknownTransactionsFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = TransactionsErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final TransactionsErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownTransactionsFailureImplCopyWith<_$UnknownTransactionsFailureImpl>
      get copyWith => __$$UnknownTransactionsFailureImplCopyWithImpl<
          _$UnknownTransactionsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TransactionsErrorType errorType, Object? rawException)?
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
    TResult Function(_TransactionsFailure value) $default, {
    required TResult Function(_UnknownTransactionsFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TransactionsFailure value)? $default, {
    TResult? Function(_UnknownTransactionsFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TransactionsFailure value)? $default, {
    TResult Function(_UnknownTransactionsFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownTransactionsFailure extends TransactionsFailure {
  const factory _UnknownTransactionsFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final TransactionsErrorType errorType,
      final Object? rawException}) = _$UnknownTransactionsFailureImpl;
  const _UnknownTransactionsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TransactionsErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of TransactionsFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownTransactionsFailureImplCopyWith<_$UnknownTransactionsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
