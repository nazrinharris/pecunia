// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoriesException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  CategoriesErrorType get errorType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            CategoriesErrorType errorType, String? message)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CategoriesException value) $default, {
    required TResult Function(_UnknownCategoriesException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesException value)? $default, {
    TResult? Function(_UnknownCategoriesException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesException value)? $default, {
    TResult Function(_UnknownCategoriesException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesExceptionCopyWith<CategoriesException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesExceptionCopyWith<$Res> {
  factory $CategoriesExceptionCopyWith(
          CategoriesException value, $Res Function(CategoriesException) then) =
      _$CategoriesExceptionCopyWithImpl<$Res, CategoriesException>;
  @useResult
  $Res call(
      {StackTrace stackTrace, CategoriesErrorType errorType, String? message});
}

/// @nodoc
class _$CategoriesExceptionCopyWithImpl<$Res, $Val extends CategoriesException>
    implements $CategoriesExceptionCopyWith<$Res> {
  _$CategoriesExceptionCopyWithImpl(this._value, this._then);

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
              as CategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesExceptionImplCopyWith<$Res>
    implements $CategoriesExceptionCopyWith<$Res> {
  factory _$$CategoriesExceptionImplCopyWith(_$CategoriesExceptionImpl value,
          $Res Function(_$CategoriesExceptionImpl) then) =
      __$$CategoriesExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, CategoriesErrorType errorType, String? message});
}

/// @nodoc
class __$$CategoriesExceptionImplCopyWithImpl<$Res>
    extends _$CategoriesExceptionCopyWithImpl<$Res, _$CategoriesExceptionImpl>
    implements _$$CategoriesExceptionImplCopyWith<$Res> {
  __$$CategoriesExceptionImplCopyWithImpl(_$CategoriesExceptionImpl _value,
      $Res Function(_$CategoriesExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$CategoriesExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as CategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CategoriesExceptionImpl implements _CategoriesException {
  const _$CategoriesExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message});

  @override
  final StackTrace stackTrace;
  @override
  final CategoriesErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'CategoriesException(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesExceptionImpl &&
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
  _$$CategoriesExceptionImplCopyWith<_$CategoriesExceptionImpl> get copyWith =>
      __$$CategoriesExceptionImplCopyWithImpl<_$CategoriesExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            CategoriesErrorType errorType, String? message)
        unknown,
  }) {
    return $default(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
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
    TResult Function(_CategoriesException value) $default, {
    required TResult Function(_UnknownCategoriesException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesException value)? $default, {
    TResult? Function(_UnknownCategoriesException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesException value)? $default, {
    TResult Function(_UnknownCategoriesException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _CategoriesException implements CategoriesException {
  const factory _CategoriesException(
      {required final StackTrace stackTrace,
      required final CategoriesErrorType errorType,
      final String? message}) = _$CategoriesExceptionImpl;

  @override
  StackTrace get stackTrace;
  @override
  CategoriesErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$CategoriesExceptionImplCopyWith<_$CategoriesExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownCategoriesExceptionImplCopyWith<$Res>
    implements $CategoriesExceptionCopyWith<$Res> {
  factory _$$UnknownCategoriesExceptionImplCopyWith(
          _$UnknownCategoriesExceptionImpl value,
          $Res Function(_$UnknownCategoriesExceptionImpl) then) =
      __$$UnknownCategoriesExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, CategoriesErrorType errorType, String? message});
}

/// @nodoc
class __$$UnknownCategoriesExceptionImplCopyWithImpl<$Res>
    extends _$CategoriesExceptionCopyWithImpl<$Res,
        _$UnknownCategoriesExceptionImpl>
    implements _$$UnknownCategoriesExceptionImplCopyWith<$Res> {
  __$$UnknownCategoriesExceptionImplCopyWithImpl(
      _$UnknownCategoriesExceptionImpl _value,
      $Res Function(_$UnknownCategoriesExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$UnknownCategoriesExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as CategoriesErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownCategoriesExceptionImpl implements _UnknownCategoriesException {
  _$UnknownCategoriesExceptionImpl(
      {required this.stackTrace,
      this.errorType = CategoriesErrorType.unknown,
      this.message});

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final CategoriesErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'CategoriesException.unknown(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownCategoriesExceptionImpl &&
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
  _$$UnknownCategoriesExceptionImplCopyWith<_$UnknownCategoriesExceptionImpl>
      get copyWith => __$$UnknownCategoriesExceptionImplCopyWithImpl<
          _$UnknownCategoriesExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)
        $default, {
    required TResult Function(StackTrace stackTrace,
            CategoriesErrorType errorType, String? message)
        unknown,
  }) {
    return unknown(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult? Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
            String? message)?
        $default, {
    TResult Function(StackTrace stackTrace, CategoriesErrorType errorType,
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
    TResult Function(_CategoriesException value) $default, {
    required TResult Function(_UnknownCategoriesException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesException value)? $default, {
    TResult? Function(_UnknownCategoriesException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesException value)? $default, {
    TResult Function(_UnknownCategoriesException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownCategoriesException implements CategoriesException {
  factory _UnknownCategoriesException(
      {required final StackTrace stackTrace,
      final CategoriesErrorType errorType,
      final String? message}) = _$UnknownCategoriesExceptionImpl;

  @override
  StackTrace get stackTrace;
  @override
  CategoriesErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UnknownCategoriesExceptionImplCopyWith<_$UnknownCategoriesExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoriesFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CategoriesErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CategoriesFailure value) $default, {
    required TResult Function(_UnknownCategoriesFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesFailure value)? $default, {
    TResult? Function(_UnknownCategoriesFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesFailure value)? $default, {
    TResult Function(_UnknownCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoriesFailureCopyWith<CategoriesFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesFailureCopyWith<$Res> {
  factory $CategoriesFailureCopyWith(
          CategoriesFailure value, $Res Function(CategoriesFailure) then) =
      _$CategoriesFailureCopyWithImpl<$Res, CategoriesFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      CategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$CategoriesFailureCopyWithImpl<$Res, $Val extends CategoriesFailure>
    implements $CategoriesFailureCopyWith<$Res> {
  _$CategoriesFailureCopyWithImpl(this._value, this._then);

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
              as CategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesFailureImplCopyWith<$Res>
    implements $CategoriesFailureCopyWith<$Res> {
  factory _$$CategoriesFailureImplCopyWith(_$CategoriesFailureImpl value,
          $Res Function(_$CategoriesFailureImpl) then) =
      __$$CategoriesFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      CategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$CategoriesFailureImplCopyWithImpl<$Res>
    extends _$CategoriesFailureCopyWithImpl<$Res, _$CategoriesFailureImpl>
    implements _$$CategoriesFailureImplCopyWith<$Res> {
  __$$CategoriesFailureImplCopyWithImpl(_$CategoriesFailureImpl _value,
      $Res Function(_$CategoriesFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$CategoriesFailureImpl(
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
              as CategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$CategoriesFailureImpl extends _CategoriesFailure {
  const _$CategoriesFailureImpl(
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
  final CategoriesErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesFailureImplCopyWith<_$CategoriesFailureImpl> get copyWith =>
      __$$CategoriesFailureImplCopyWithImpl<_$CategoriesFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
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
    TResult Function(_CategoriesFailure value) $default, {
    required TResult Function(_UnknownCategoriesFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesFailure value)? $default, {
    TResult? Function(_UnknownCategoriesFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesFailure value)? $default, {
    TResult Function(_UnknownCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _CategoriesFailure extends CategoriesFailure {
  const factory _CategoriesFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final CategoriesErrorType errorType,
      final Object? rawException}) = _$CategoriesFailureImpl;
  const _CategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  CategoriesErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$CategoriesFailureImplCopyWith<_$CategoriesFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownCategoriesFailureImplCopyWith<$Res>
    implements $CategoriesFailureCopyWith<$Res> {
  factory _$$UnknownCategoriesFailureImplCopyWith(
          _$UnknownCategoriesFailureImpl value,
          $Res Function(_$UnknownCategoriesFailureImpl) then) =
      __$$UnknownCategoriesFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      CategoriesErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownCategoriesFailureImplCopyWithImpl<$Res>
    extends _$CategoriesFailureCopyWithImpl<$Res,
        _$UnknownCategoriesFailureImpl>
    implements _$$UnknownCategoriesFailureImplCopyWith<$Res> {
  __$$UnknownCategoriesFailureImplCopyWithImpl(
      _$UnknownCategoriesFailureImpl _value,
      $Res Function(_$UnknownCategoriesFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownCategoriesFailureImpl(
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
              as CategoriesErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$UnknownCategoriesFailureImpl extends _UnknownCategoriesFailure {
  const _$UnknownCategoriesFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = CategoriesErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final CategoriesErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownCategoriesFailureImplCopyWith<_$UnknownCategoriesFailureImpl>
      get copyWith => __$$UnknownCategoriesFailureImplCopyWithImpl<
          _$UnknownCategoriesFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            CategoriesErrorType errorType, Object? rawException)?
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
    TResult Function(_CategoriesFailure value) $default, {
    required TResult Function(_UnknownCategoriesFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategoriesFailure value)? $default, {
    TResult? Function(_UnknownCategoriesFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategoriesFailure value)? $default, {
    TResult Function(_UnknownCategoriesFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownCategoriesFailure extends CategoriesFailure {
  const factory _UnknownCategoriesFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final CategoriesErrorType errorType,
      final Object? rawException}) = _$UnknownCategoriesFailureImpl;
  const _UnknownCategoriesFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  CategoriesErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$UnknownCategoriesFailureImplCopyWith<_$UnknownCategoriesFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
