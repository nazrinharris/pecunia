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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransactionsException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  TransactionsErrorType get errorType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)
        $default, {
    required TResult Function(
            StackTrace stackTrace, TransactionsErrorType errorType)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType)?
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

  @JsonKey(ignore: true)
  $TransactionsExceptionCopyWith<TransactionsException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsExceptionCopyWith<$Res> {
  factory $TransactionsExceptionCopyWith(TransactionsException value,
          $Res Function(TransactionsException) then) =
      _$TransactionsExceptionCopyWithImpl<$Res, TransactionsException>;
  @useResult
  $Res call({StackTrace stackTrace, TransactionsErrorType errorType});
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
              as TransactionsErrorType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionsExceptionCopyWith<$Res>
    implements $TransactionsExceptionCopyWith<$Res> {
  factory _$$_TransactionsExceptionCopyWith(_$_TransactionsException value,
          $Res Function(_$_TransactionsException) then) =
      __$$_TransactionsExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      TransactionsErrorType errorType,
      TransactionsAction transactionsAction});
}

/// @nodoc
class __$$_TransactionsExceptionCopyWithImpl<$Res>
    extends _$TransactionsExceptionCopyWithImpl<$Res, _$_TransactionsException>
    implements _$$_TransactionsExceptionCopyWith<$Res> {
  __$$_TransactionsExceptionCopyWithImpl(_$_TransactionsException _value,
      $Res Function(_$_TransactionsException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? transactionsAction = null,
  }) {
    return _then(_$_TransactionsException(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TransactionsErrorType,
      transactionsAction: null == transactionsAction
          ? _value.transactionsAction
          : transactionsAction // ignore: cast_nullable_to_non_nullable
              as TransactionsAction,
    ));
  }
}

/// @nodoc

class _$_TransactionsException extends _TransactionsException {
  _$_TransactionsException(
      {required this.stackTrace,
      required this.errorType,
      required this.transactionsAction})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final TransactionsErrorType errorType;
  @override
  final TransactionsAction transactionsAction;

  @override
  String toString() {
    return 'TransactionsException(stackTrace: $stackTrace, errorType: $errorType, transactionsAction: $transactionsAction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionsException &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.transactionsAction, transactionsAction) ||
                other.transactionsAction == transactionsAction));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, stackTrace, errorType, transactionsAction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionsExceptionCopyWith<_$_TransactionsException> get copyWith =>
      __$$_TransactionsExceptionCopyWithImpl<_$_TransactionsException>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)
        $default, {
    required TResult Function(
            StackTrace stackTrace, TransactionsErrorType errorType)
        unknown,
  }) {
    return $default(stackTrace, errorType, transactionsAction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, transactionsAction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType)?
        unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(stackTrace, errorType, transactionsAction);
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
          required final TransactionsAction transactionsAction}) =
      _$_TransactionsException;
  _TransactionsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  TransactionsErrorType get errorType;
  TransactionsAction get transactionsAction;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionsExceptionCopyWith<_$_TransactionsException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownTransactionsExceptionCopyWith<$Res>
    implements $TransactionsExceptionCopyWith<$Res> {
  factory _$$_UnknownTransactionsExceptionCopyWith(
          _$_UnknownTransactionsException value,
          $Res Function(_$_UnknownTransactionsException) then) =
      __$$_UnknownTransactionsExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, TransactionsErrorType errorType});
}

/// @nodoc
class __$$_UnknownTransactionsExceptionCopyWithImpl<$Res>
    extends _$TransactionsExceptionCopyWithImpl<$Res,
        _$_UnknownTransactionsException>
    implements _$$_UnknownTransactionsExceptionCopyWith<$Res> {
  __$$_UnknownTransactionsExceptionCopyWithImpl(
      _$_UnknownTransactionsException _value,
      $Res Function(_$_UnknownTransactionsException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
  }) {
    return _then(_$_UnknownTransactionsException(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as TransactionsErrorType,
    ));
  }
}

/// @nodoc

class _$_UnknownTransactionsException extends _UnknownTransactionsException {
  _$_UnknownTransactionsException(
      {required this.stackTrace, required this.errorType})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final TransactionsErrorType errorType;

  @override
  String toString() {
    return 'TransactionsException.unknown(stackTrace: $stackTrace, errorType: $errorType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnknownTransactionsException &&
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
  _$$_UnknownTransactionsExceptionCopyWith<_$_UnknownTransactionsException>
      get copyWith => __$$_UnknownTransactionsExceptionCopyWithImpl<
          _$_UnknownTransactionsException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)
        $default, {
    required TResult Function(
            StackTrace stackTrace, TransactionsErrorType errorType)
        unknown,
  }) {
    return unknown(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult? Function(StackTrace stackTrace, TransactionsErrorType errorType)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType,
            TransactionsAction transactionsAction)?
        $default, {
    TResult Function(StackTrace stackTrace, TransactionsErrorType errorType)?
        unknown,
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
          required final TransactionsErrorType errorType}) =
      _$_UnknownTransactionsException;
  _UnknownTransactionsException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  TransactionsErrorType get errorType;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownTransactionsExceptionCopyWith<_$_UnknownTransactionsException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionsFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  TransactionsAction get transactionsAction =>
      throw _privateConstructorUsedError;
  TransactionsErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
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

  @JsonKey(ignore: true)
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
      TransactionsAction transactionsAction,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? transactionsAction = null,
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
      transactionsAction: null == transactionsAction
          ? _value.transactionsAction
          : transactionsAction // ignore: cast_nullable_to_non_nullable
              as TransactionsAction,
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
abstract class _$$_TransactionsFailureCopyWith<$Res>
    implements $TransactionsFailureCopyWith<$Res> {
  factory _$$_TransactionsFailureCopyWith(_$_TransactionsFailure value,
          $Res Function(_$_TransactionsFailure) then) =
      __$$_TransactionsFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TransactionsAction transactionsAction,
      TransactionsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_TransactionsFailureCopyWithImpl<$Res>
    extends _$TransactionsFailureCopyWithImpl<$Res, _$_TransactionsFailure>
    implements _$$_TransactionsFailureCopyWith<$Res> {
  __$$_TransactionsFailureCopyWithImpl(_$_TransactionsFailure _value,
      $Res Function(_$_TransactionsFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? transactionsAction = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_TransactionsFailure(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      transactionsAction: null == transactionsAction
          ? _value.transactionsAction
          : transactionsAction // ignore: cast_nullable_to_non_nullable
              as TransactionsAction,
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

class _$_TransactionsFailure extends _TransactionsFailure {
  const _$_TransactionsFailure(
      {required this.stackTrace,
      required this.message,
      required this.transactionsAction,
      required this.errorType,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  final TransactionsAction transactionsAction;
  @override
  final TransactionsErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionsFailureCopyWith<_$_TransactionsFailure> get copyWith =>
      __$$_TransactionsFailureCopyWithImpl<_$_TransactionsFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        unknown,
  }) {
    return $default(
        stackTrace, message, transactionsAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        unknown,
  }) {
    return $default?.call(
        stackTrace, message, transactionsAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          stackTrace, message, transactionsAction, errorType, rawException);
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
      required final TransactionsAction transactionsAction,
      required final TransactionsErrorType errorType,
      final Object? rawException}) = _$_TransactionsFailure;
  const _TransactionsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TransactionsAction get transactionsAction;
  @override
  TransactionsErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionsFailureCopyWith<_$_TransactionsFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownTransactionsFailureCopyWith<$Res>
    implements $TransactionsFailureCopyWith<$Res> {
  factory _$$_UnknownTransactionsFailureCopyWith(
          _$_UnknownTransactionsFailure value,
          $Res Function(_$_UnknownTransactionsFailure) then) =
      __$$_UnknownTransactionsFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      TransactionsAction transactionsAction,
      TransactionsErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_UnknownTransactionsFailureCopyWithImpl<$Res>
    extends _$TransactionsFailureCopyWithImpl<$Res,
        _$_UnknownTransactionsFailure>
    implements _$$_UnknownTransactionsFailureCopyWith<$Res> {
  __$$_UnknownTransactionsFailureCopyWithImpl(
      _$_UnknownTransactionsFailure _value,
      $Res Function(_$_UnknownTransactionsFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? transactionsAction = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_UnknownTransactionsFailure(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      transactionsAction: null == transactionsAction
          ? _value.transactionsAction
          : transactionsAction // ignore: cast_nullable_to_non_nullable
              as TransactionsAction,
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

class _$_UnknownTransactionsFailure extends _UnknownTransactionsFailure {
  const _$_UnknownTransactionsFailure(
      {required this.stackTrace,
      required this.message,
      required this.transactionsAction,
      this.errorType = TransactionsErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  final TransactionsAction transactionsAction;
  @override
  @JsonKey()
  final TransactionsErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownTransactionsFailureCopyWith<_$_UnknownTransactionsFailure>
      get copyWith => __$$_UnknownTransactionsFailureCopyWithImpl<
          _$_UnknownTransactionsFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        $default, {
    required TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)
        unknown,
  }) {
    return unknown(
        stackTrace, message, transactionsAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult? Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        unknown,
  }) {
    return unknown?.call(
        stackTrace, message, transactionsAction, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        $default, {
    TResult Function(
            StackTrace stackTrace,
            String message,
            TransactionsAction transactionsAction,
            TransactionsErrorType errorType,
            Object? rawException)?
        unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(
          stackTrace, message, transactionsAction, errorType, rawException);
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
      required final TransactionsAction transactionsAction,
      final TransactionsErrorType errorType,
      final Object? rawException}) = _$_UnknownTransactionsFailure;
  const _UnknownTransactionsFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  TransactionsAction get transactionsAction;
  @override
  TransactionsErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownTransactionsFailureCopyWith<_$_UnknownTransactionsFailure>
      get copyWith => throw _privateConstructorUsedError;
}
