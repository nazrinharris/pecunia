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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  @JsonKey(ignore: true)
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
abstract class _$$_TxnCategoriesExceptionCopyWith<$Res>
    implements $TxnCategoriesExceptionCopyWith<$Res> {
  factory _$$_TxnCategoriesExceptionCopyWith(_$_TxnCategoriesException value,
          $Res Function(_$_TxnCategoriesException) then) =
      __$$_TxnCategoriesExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TxnCategoriesErrorType errorType,
      String? message});
}

/// @nodoc
class __$$_TxnCategoriesExceptionCopyWithImpl<$Res>
    extends _$TxnCategoriesExceptionCopyWithImpl<$Res,
        _$_TxnCategoriesException>
    implements _$$_TxnCategoriesExceptionCopyWith<$Res> {
  __$$_TxnCategoriesExceptionCopyWithImpl(_$_TxnCategoriesException _value,
      $Res Function(_$_TxnCategoriesException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$_TxnCategoriesException(
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

class _$_TxnCategoriesException implements _TxnCategoriesException {
  const _$_TxnCategoriesException(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TxnCategoriesException &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TxnCategoriesExceptionCopyWith<_$_TxnCategoriesException> get copyWith =>
      __$$_TxnCategoriesExceptionCopyWithImpl<_$_TxnCategoriesException>(
          this, _$identity);

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
      final String? message}) = _$_TxnCategoriesException;

  @override
  StackTrace get stackTrace;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_TxnCategoriesExceptionCopyWith<_$_TxnCategoriesException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownTxnCategoriesExceptionCopyWith<$Res>
    implements $TxnCategoriesExceptionCopyWith<$Res> {
  factory _$$_UnknownTxnCategoriesExceptionCopyWith(
          _$_UnknownTxnCategoriesException value,
          $Res Function(_$_UnknownTxnCategoriesException) then) =
      __$$_UnknownTxnCategoriesExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TxnCategoriesErrorType errorType,
      String? message});
}

/// @nodoc
class __$$_UnknownTxnCategoriesExceptionCopyWithImpl<$Res>
    extends _$TxnCategoriesExceptionCopyWithImpl<$Res,
        _$_UnknownTxnCategoriesException>
    implements _$$_UnknownTxnCategoriesExceptionCopyWith<$Res> {
  __$$_UnknownTxnCategoriesExceptionCopyWithImpl(
      _$_UnknownTxnCategoriesException _value,
      $Res Function(_$_UnknownTxnCategoriesException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$_UnknownTxnCategoriesException(
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

class _$_UnknownTxnCategoriesException
    implements _UnknownTxnCategoriesException {
  _$_UnknownTxnCategoriesException(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnknownTxnCategoriesException &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, errorType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownTxnCategoriesExceptionCopyWith<_$_UnknownTxnCategoriesException>
      get copyWith => __$$_UnknownTxnCategoriesExceptionCopyWithImpl<
          _$_UnknownTxnCategoriesException>(this, _$identity);

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
      final String? message}) = _$_UnknownTxnCategoriesException;

  @override
  StackTrace get stackTrace;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownTxnCategoriesExceptionCopyWith<_$_UnknownTxnCategoriesException>
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

  @JsonKey(ignore: true)
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
abstract class _$$_TxnCategoriesFailureCopyWith<$Res>
    implements $TxnCategoriesFailureCopyWith<$Res> {
  factory _$$_TxnCategoriesFailureCopyWith(_$_TxnCategoriesFailure value,
          $Res Function(_$_TxnCategoriesFailure) then) =
      __$$_TxnCategoriesFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TxnCategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_TxnCategoriesFailureCopyWithImpl<$Res>
    extends _$TxnCategoriesFailureCopyWithImpl<$Res, _$_TxnCategoriesFailure>
    implements _$$_TxnCategoriesFailureCopyWith<$Res> {
  __$$_TxnCategoriesFailureCopyWithImpl(_$_TxnCategoriesFailure _value,
      $Res Function(_$_TxnCategoriesFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_TxnCategoriesFailure(
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

class _$_TxnCategoriesFailure extends _TxnCategoriesFailure {
  const _$_TxnCategoriesFailure(
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TxnCategoriesFailureCopyWith<_$_TxnCategoriesFailure> get copyWith =>
      __$$_TxnCategoriesFailureCopyWithImpl<_$_TxnCategoriesFailure>(
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
      final Object? rawException}) = _$_TxnCategoriesFailure;
  const _TxnCategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_TxnCategoriesFailureCopyWith<_$_TxnCategoriesFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownTxnCategoriesFailureCopyWith<$Res>
    implements $TxnCategoriesFailureCopyWith<$Res> {
  factory _$$_UnknownTxnCategoriesFailureCopyWith(
          _$_UnknownTxnCategoriesFailure value,
          $Res Function(_$_UnknownTxnCategoriesFailure) then) =
      __$$_UnknownTxnCategoriesFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TxnCategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_UnknownTxnCategoriesFailureCopyWithImpl<$Res>
    extends _$TxnCategoriesFailureCopyWithImpl<$Res,
        _$_UnknownTxnCategoriesFailure>
    implements _$$_UnknownTxnCategoriesFailureCopyWith<$Res> {
  __$$_UnknownTxnCategoriesFailureCopyWithImpl(
      _$_UnknownTxnCategoriesFailure _value,
      $Res Function(_$_UnknownTxnCategoriesFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_UnknownTxnCategoriesFailure(
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

class _$_UnknownTxnCategoriesFailure extends _UnknownTxnCategoriesFailure {
  const _$_UnknownTxnCategoriesFailure(
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownTxnCategoriesFailureCopyWith<_$_UnknownTxnCategoriesFailure>
      get copyWith => __$$_UnknownTxnCategoriesFailureCopyWithImpl<
          _$_UnknownTxnCategoriesFailure>(this, _$identity);

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
      final Object? rawException}) = _$_UnknownTxnCategoriesFailure;
  const _UnknownTxnCategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TxnCategoriesErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownTxnCategoriesFailureCopyWith<_$_UnknownTxnCategoriesFailure>
      get copyWith => throw _privateConstructorUsedError;
}
