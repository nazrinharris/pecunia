// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'txn_categories_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TxnCategoriesException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  TxnCategoriesErrorType get errorType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TxnCategoriesErrorType errorType, String? message)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TxnCategoriesException value) $default, {
    required TResult Function(_UnknownTxnCategoriesException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesException value)? $default, {
    TResult? Function(_UnknownTxnCategoriesException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesException value)? $default, {
    TResult Function(_UnknownTxnCategoriesException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxnCategoriesExceptionCopyWith<TxnCategoriesException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxnCategoriesExceptionCopyWith<$Res> {
  factory $TxnCategoriesExceptionCopyWith(TxnCategoriesException value,
          $Res Function(TxnCategoriesException) then) =
      _$TxnCategoriesExceptionCopyWithImpl<$Res, TxnCategoriesException>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TxnCategoriesErrorType errorType,
      String? message});
}

/// @nodoc
class _$TxnCategoriesExceptionCopyWithImpl<$Res,
        $Val extends TxnCategoriesException>
    implements $TxnCategoriesExceptionCopyWith<$Res> {
  _$TxnCategoriesExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxnCategoriesException
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
              as TxnCategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxnCategoriesExceptionImplCopyWith<$Res>
    implements $TxnCategoriesExceptionCopyWith<$Res> {
  factory _$$TxnCategoriesExceptionImplCopyWith(
          _$TxnCategoriesExceptionImpl value,
          $Res Function(_$TxnCategoriesExceptionImpl) then) =
      __$$TxnCategoriesExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TxnCategoriesErrorType errorType,
      String? message});
}

/// @nodoc
class __$$TxnCategoriesExceptionImplCopyWithImpl<$Res>
    extends _$TxnCategoriesExceptionCopyWithImpl<$Res,
        _$TxnCategoriesExceptionImpl>
    implements _$$TxnCategoriesExceptionImplCopyWith<$Res> {
  __$$TxnCategoriesExceptionImplCopyWithImpl(
      _$TxnCategoriesExceptionImpl _value,
      $Res Function(_$TxnCategoriesExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$TxnCategoriesExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TxnCategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TxnCategoriesExceptionImpl implements _TxnCategoriesException {
  const _$TxnCategoriesExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message});

  @override
  final StackTrace stackTrace;
  @override
  final TxnCategoriesErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'TxnCategoriesException(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxnCategoriesExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxnCategoriesExceptionImplCopyWith<_$TxnCategoriesExceptionImpl>
      get copyWith => __$$TxnCategoriesExceptionImplCopyWithImpl<
          _$TxnCategoriesExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TxnCategoriesErrorType errorType, String? message)
        unknown,
  }) {
    return $default(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
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
    TResult Function(_TxnCategoriesException value) $default, {
    required TResult Function(_UnknownTxnCategoriesException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesException value)? $default, {
    TResult? Function(_UnknownTxnCategoriesException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesException value)? $default, {
    TResult Function(_UnknownTxnCategoriesException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _TxnCategoriesException implements TxnCategoriesException {
  const factory _TxnCategoriesException(
      {required final StackTrace stackTrace,
      required final TxnCategoriesErrorType errorType,
      final String? message}) = _$TxnCategoriesExceptionImpl;

  @override
  StackTrace get stackTrace;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxnCategoriesExceptionImplCopyWith<_$TxnCategoriesExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownTxnCategoriesExceptionImplCopyWith<$Res>
    implements $TxnCategoriesExceptionCopyWith<$Res> {
  factory _$$UnknownTxnCategoriesExceptionImplCopyWith(
          _$UnknownTxnCategoriesExceptionImpl value,
          $Res Function(_$UnknownTxnCategoriesExceptionImpl) then) =
      __$$UnknownTxnCategoriesExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TxnCategoriesErrorType errorType,
      String? message});
}

/// @nodoc
class __$$UnknownTxnCategoriesExceptionImplCopyWithImpl<$Res>
    extends _$TxnCategoriesExceptionCopyWithImpl<$Res,
        _$UnknownTxnCategoriesExceptionImpl>
    implements _$$UnknownTxnCategoriesExceptionImplCopyWith<$Res> {
  __$$UnknownTxnCategoriesExceptionImplCopyWithImpl(
      _$UnknownTxnCategoriesExceptionImpl _value,
      $Res Function(_$UnknownTxnCategoriesExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$UnknownTxnCategoriesExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TxnCategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownTxnCategoriesExceptionImpl
    implements _UnknownTxnCategoriesException {
  _$UnknownTxnCategoriesExceptionImpl(
      {required this.stackTrace,
      this.errorType = TxnCategoriesErrorType.unknown,
      this.message});

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final TxnCategoriesErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'TxnCategoriesException.unknown(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownTxnCategoriesExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownTxnCategoriesExceptionImplCopyWith<
          _$UnknownTxnCategoriesExceptionImpl>
      get copyWith => __$$UnknownTxnCategoriesExceptionImplCopyWithImpl<
          _$UnknownTxnCategoriesExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            TxnCategoriesErrorType errorType, String? message)
        unknown,
  }) {
    return unknown(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, TxnCategoriesErrorType errorType,
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
    TResult Function(_TxnCategoriesException value) $default, {
    required TResult Function(_UnknownTxnCategoriesException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesException value)? $default, {
    TResult? Function(_UnknownTxnCategoriesException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesException value)? $default, {
    TResult Function(_UnknownTxnCategoriesException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownTxnCategoriesException
    implements TxnCategoriesException {
  factory _UnknownTxnCategoriesException(
      {required final StackTrace stackTrace,
      final TxnCategoriesErrorType errorType,
      final String? message}) = _$UnknownTxnCategoriesExceptionImpl;

  @override
  StackTrace get stackTrace;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  String? get message;

  /// Create a copy of TxnCategoriesException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownTxnCategoriesExceptionImplCopyWith<
          _$UnknownTxnCategoriesExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TxnCategoriesFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  TxnCategoriesErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TxnCategoriesFailure value) $default, {
    required TResult Function(_UnknownTxnCategoriesFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesFailure value)? $default, {
    TResult? Function(_UnknownTxnCategoriesFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesFailure value)? $default, {
    TResult Function(_UnknownTxnCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxnCategoriesFailureCopyWith<TxnCategoriesFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxnCategoriesFailureCopyWith<$Res> {
  factory $TxnCategoriesFailureCopyWith(TxnCategoriesFailure value,
          $Res Function(TxnCategoriesFailure) then) =
      _$TxnCategoriesFailureCopyWithImpl<$Res, TxnCategoriesFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TxnCategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$TxnCategoriesFailureCopyWithImpl<$Res,
        $Val extends TxnCategoriesFailure>
    implements $TxnCategoriesFailureCopyWith<$Res> {
  _$TxnCategoriesFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxnCategoriesFailure
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
              as TxnCategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxnCategoriesFailureImplCopyWith<$Res>
    implements $TxnCategoriesFailureCopyWith<$Res> {
  factory _$$TxnCategoriesFailureImplCopyWith(_$TxnCategoriesFailureImpl value,
          $Res Function(_$TxnCategoriesFailureImpl) then) =
      __$$TxnCategoriesFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TxnCategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$TxnCategoriesFailureImplCopyWithImpl<$Res>
    extends _$TxnCategoriesFailureCopyWithImpl<$Res, _$TxnCategoriesFailureImpl>
    implements _$$TxnCategoriesFailureImplCopyWith<$Res> {
  __$$TxnCategoriesFailureImplCopyWithImpl(_$TxnCategoriesFailureImpl _value,
      $Res Function(_$TxnCategoriesFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$TxnCategoriesFailureImpl(
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
              as TxnCategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$TxnCategoriesFailureImpl extends _TxnCategoriesFailure {
  const _$TxnCategoriesFailureImpl(
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
  final TxnCategoriesErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxnCategoriesFailureImplCopyWith<_$TxnCategoriesFailureImpl>
      get copyWith =>
          __$$TxnCategoriesFailureImplCopyWithImpl<_$TxnCategoriesFailureImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
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
    TResult Function(_TxnCategoriesFailure value) $default, {
    required TResult Function(_UnknownTxnCategoriesFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesFailure value)? $default, {
    TResult? Function(_UnknownTxnCategoriesFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesFailure value)? $default, {
    TResult Function(_UnknownTxnCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _TxnCategoriesFailure extends TxnCategoriesFailure {
  const factory _TxnCategoriesFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final TxnCategoriesErrorType errorType,
      final Object? rawException}) = _$TxnCategoriesFailureImpl;
  const _TxnCategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxnCategoriesFailureImplCopyWith<_$TxnCategoriesFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownTxnCategoriesFailureImplCopyWith<$Res>
    implements $TxnCategoriesFailureCopyWith<$Res> {
  factory _$$UnknownTxnCategoriesFailureImplCopyWith(
          _$UnknownTxnCategoriesFailureImpl value,
          $Res Function(_$UnknownTxnCategoriesFailureImpl) then) =
      __$$UnknownTxnCategoriesFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TxnCategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownTxnCategoriesFailureImplCopyWithImpl<$Res>
    extends _$TxnCategoriesFailureCopyWithImpl<$Res,
        _$UnknownTxnCategoriesFailureImpl>
    implements _$$UnknownTxnCategoriesFailureImplCopyWith<$Res> {
  __$$UnknownTxnCategoriesFailureImplCopyWithImpl(
      _$UnknownTxnCategoriesFailureImpl _value,
      $Res Function(_$UnknownTxnCategoriesFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownTxnCategoriesFailureImpl(
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
              as TxnCategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$UnknownTxnCategoriesFailureImpl extends _UnknownTxnCategoriesFailure {
  const _$UnknownTxnCategoriesFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = TxnCategoriesErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final TxnCategoriesErrorType errorType;
  @override
  final Object? rawException;

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownTxnCategoriesFailureImplCopyWith<_$UnknownTxnCategoriesFailureImpl>
      get copyWith => __$$UnknownTxnCategoriesFailureImplCopyWithImpl<
          _$UnknownTxnCategoriesFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            TxnCategoriesErrorType errorType, Object? rawException)?
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
    TResult Function(_TxnCategoriesFailure value) $default, {
    required TResult Function(_UnknownTxnCategoriesFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TxnCategoriesFailure value)? $default, {
    TResult? Function(_UnknownTxnCategoriesFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TxnCategoriesFailure value)? $default, {
    TResult Function(_UnknownTxnCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownTxnCategoriesFailure extends TxnCategoriesFailure {
  const factory _UnknownTxnCategoriesFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final TxnCategoriesErrorType errorType,
      final Object? rawException}) = _$UnknownTxnCategoriesFailureImpl;
  const _UnknownTxnCategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  Object? get rawException;

  /// Create a copy of TxnCategoriesFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownTxnCategoriesFailureImplCopyWith<_$UnknownTxnCategoriesFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
