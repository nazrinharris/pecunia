// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_info_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppInfoFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AppInfoErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppInfoFailure value) $default, {
    required TResult Function(_UnknownAppInfoFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoFailure value)? $default, {
    TResult? Function(_UnknownAppInfoFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoFailure value)? $default, {
    TResult Function(_UnknownAppInfoFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppInfoFailureCopyWith<AppInfoFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInfoFailureCopyWith<$Res> {
  factory $AppInfoFailureCopyWith(
          AppInfoFailure value, $Res Function(AppInfoFailure) then) =
      _$AppInfoFailureCopyWithImpl<$Res, AppInfoFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AppInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$AppInfoFailureCopyWithImpl<$Res, $Val extends AppInfoFailure>
    implements $AppInfoFailureCopyWith<$Res> {
  _$AppInfoFailureCopyWithImpl(this._value, this._then);

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
              as AppInfoErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInfoFailureImplCopyWith<$Res>
    implements $AppInfoFailureCopyWith<$Res> {
  factory _$$AppInfoFailureImplCopyWith(_$AppInfoFailureImpl value,
          $Res Function(_$AppInfoFailureImpl) then) =
      __$$AppInfoFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AppInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$AppInfoFailureImplCopyWithImpl<$Res>
    extends _$AppInfoFailureCopyWithImpl<$Res, _$AppInfoFailureImpl>
    implements _$$AppInfoFailureImplCopyWith<$Res> {
  __$$AppInfoFailureImplCopyWithImpl(
      _$AppInfoFailureImpl _value, $Res Function(_$AppInfoFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$AppInfoFailureImpl(
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
              as AppInfoErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$AppInfoFailureImpl extends _AppInfoFailure {
  const _$AppInfoFailureImpl(
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
  final AppInfoErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInfoFailureImplCopyWith<_$AppInfoFailureImpl> get copyWith =>
      __$$AppInfoFailureImplCopyWithImpl<_$AppInfoFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        unknown,
  }) {
    return $default(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return $default?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
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
    TResult Function(_AppInfoFailure value) $default, {
    required TResult Function(_UnknownAppInfoFailure value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoFailure value)? $default, {
    TResult? Function(_UnknownAppInfoFailure value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoFailure value)? $default, {
    TResult Function(_UnknownAppInfoFailure value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AppInfoFailure extends AppInfoFailure {
  const factory _AppInfoFailure(
      {required final StackTrace stackTrace,
      required final String message,
      required final AppInfoErrorType errorType,
      final Object? rawException}) = _$AppInfoFailureImpl;
  const _AppInfoFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AppInfoErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$AppInfoFailureImplCopyWith<_$AppInfoFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAppInfoFailureImplCopyWith<$Res>
    implements $AppInfoFailureCopyWith<$Res> {
  factory _$$UnknownAppInfoFailureImplCopyWith(
          _$UnknownAppInfoFailureImpl value,
          $Res Function(_$UnknownAppInfoFailureImpl) then) =
      __$$UnknownAppInfoFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AppInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$UnknownAppInfoFailureImplCopyWithImpl<$Res>
    extends _$AppInfoFailureCopyWithImpl<$Res, _$UnknownAppInfoFailureImpl>
    implements _$$UnknownAppInfoFailureImplCopyWith<$Res> {
  __$$UnknownAppInfoFailureImplCopyWithImpl(_$UnknownAppInfoFailureImpl _value,
      $Res Function(_$UnknownAppInfoFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$UnknownAppInfoFailureImpl(
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
              as AppInfoErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$UnknownAppInfoFailureImpl extends _UnknownAppInfoFailure {
  const _$UnknownAppInfoFailureImpl(
      {required this.stackTrace,
      required this.message,
      this.errorType = AppInfoErrorType.unknown,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final String message;
  @override
  @JsonKey()
  final AppInfoErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownAppInfoFailureImplCopyWith<_$UnknownAppInfoFailureImpl>
      get copyWith => __$$UnknownAppInfoFailureImplCopyWithImpl<
          _$UnknownAppInfoFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        $default, {
    required TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)
        unknown,
  }) {
    return unknown(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult? Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        unknown,
  }) {
    return unknown?.call(stackTrace, message, errorType, rawException);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
        $default, {
    TResult Function(StackTrace stackTrace, String message,
            AppInfoErrorType errorType, Object? rawException)?
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
    TResult Function(_AppInfoFailure value) $default, {
    required TResult Function(_UnknownAppInfoFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoFailure value)? $default, {
    TResult? Function(_UnknownAppInfoFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoFailure value)? $default, {
    TResult Function(_UnknownAppInfoFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAppInfoFailure extends AppInfoFailure {
  const factory _UnknownAppInfoFailure(
      {required final StackTrace stackTrace,
      required final String message,
      final AppInfoErrorType errorType,
      final Object? rawException}) = _$UnknownAppInfoFailureImpl;
  const _UnknownAppInfoFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  AppInfoErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$UnknownAppInfoFailureImplCopyWith<_$UnknownAppInfoFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppInfoException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  AppInfoErrorType get errorType => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppInfoException value) $default, {
    required TResult Function(_UnknownAppInfoException value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoException value)? $default, {
    TResult? Function(_UnknownAppInfoException value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoException value)? $default, {
    TResult Function(_UnknownAppInfoException value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppInfoExceptionCopyWith<AppInfoException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInfoExceptionCopyWith<$Res> {
  factory $AppInfoExceptionCopyWith(
          AppInfoException value, $Res Function(AppInfoException) then) =
      _$AppInfoExceptionCopyWithImpl<$Res, AppInfoException>;
  @useResult
  $Res call(
      {StackTrace stackTrace, AppInfoErrorType errorType, String? message});
}

/// @nodoc
class _$AppInfoExceptionCopyWithImpl<$Res, $Val extends AppInfoException>
    implements $AppInfoExceptionCopyWith<$Res> {
  _$AppInfoExceptionCopyWithImpl(this._value, this._then);

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
              as AppInfoErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInfoExceptionImplCopyWith<$Res>
    implements $AppInfoExceptionCopyWith<$Res> {
  factory _$$AppInfoExceptionImplCopyWith(_$AppInfoExceptionImpl value,
          $Res Function(_$AppInfoExceptionImpl) then) =
      __$$AppInfoExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AppInfoErrorType errorType, String? message});
}

/// @nodoc
class __$$AppInfoExceptionImplCopyWithImpl<$Res>
    extends _$AppInfoExceptionCopyWithImpl<$Res, _$AppInfoExceptionImpl>
    implements _$$AppInfoExceptionImplCopyWith<$Res> {
  __$$AppInfoExceptionImplCopyWithImpl(_$AppInfoExceptionImpl _value,
      $Res Function(_$AppInfoExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$AppInfoExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AppInfoErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AppInfoExceptionImpl extends _AppInfoException {
  _$AppInfoExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AppInfoErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'AppInfoException(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInfoExceptionImpl &&
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
  _$$AppInfoExceptionImplCopyWith<_$AppInfoExceptionImpl> get copyWith =>
      __$$AppInfoExceptionImplCopyWithImpl<_$AppInfoExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        unknown,
  }) {
    return $default(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        unknown,
  }) {
    return $default?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
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
    TResult Function(_AppInfoException value) $default, {
    required TResult Function(_UnknownAppInfoException value) unknown,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoException value)? $default, {
    TResult? Function(_UnknownAppInfoException value)? unknown,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoException value)? $default, {
    TResult Function(_UnknownAppInfoException value)? unknown,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _AppInfoException extends AppInfoException {
  factory _AppInfoException(
      {required final StackTrace stackTrace,
      required final AppInfoErrorType errorType,
      final String? message}) = _$AppInfoExceptionImpl;
  _AppInfoException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AppInfoErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AppInfoExceptionImplCopyWith<_$AppInfoExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownAppInfoExceptionImplCopyWith<$Res>
    implements $AppInfoExceptionCopyWith<$Res> {
  factory _$$UnknownAppInfoExceptionImplCopyWith(
          _$UnknownAppInfoExceptionImpl value,
          $Res Function(_$UnknownAppInfoExceptionImpl) then) =
      __$$UnknownAppInfoExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AppInfoErrorType errorType, String? message});
}

/// @nodoc
class __$$UnknownAppInfoExceptionImplCopyWithImpl<$Res>
    extends _$AppInfoExceptionCopyWithImpl<$Res, _$UnknownAppInfoExceptionImpl>
    implements _$$UnknownAppInfoExceptionImplCopyWith<$Res> {
  __$$UnknownAppInfoExceptionImplCopyWithImpl(
      _$UnknownAppInfoExceptionImpl _value,
      $Res Function(_$UnknownAppInfoExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$UnknownAppInfoExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      errorType: null == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AppInfoErrorType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownAppInfoExceptionImpl extends _UnknownAppInfoException {
  _$UnknownAppInfoExceptionImpl(
      {required this.stackTrace, required this.errorType, this.message})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  final AppInfoErrorType errorType;
  @override
  final String? message;

  @override
  String toString() {
    return 'AppInfoException.unknown(stackTrace: $stackTrace, errorType: $errorType, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownAppInfoExceptionImpl &&
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
  _$$UnknownAppInfoExceptionImplCopyWith<_$UnknownAppInfoExceptionImpl>
      get copyWith => __$$UnknownAppInfoExceptionImplCopyWithImpl<
          _$UnknownAppInfoExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        $default, {
    required TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)
        unknown,
  }) {
    return unknown(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult? Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        unknown,
  }) {
    return unknown?.call(stackTrace, errorType, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
        $default, {
    TResult Function(
            StackTrace stackTrace, AppInfoErrorType errorType, String? message)?
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
    TResult Function(_AppInfoException value) $default, {
    required TResult Function(_UnknownAppInfoException value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppInfoException value)? $default, {
    TResult? Function(_UnknownAppInfoException value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppInfoException value)? $default, {
    TResult Function(_UnknownAppInfoException value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownAppInfoException extends AppInfoException {
  factory _UnknownAppInfoException(
      {required final StackTrace stackTrace,
      required final AppInfoErrorType errorType,
      final String? message}) = _$UnknownAppInfoExceptionImpl;
  _UnknownAppInfoException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AppInfoErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UnknownAppInfoExceptionImplCopyWith<_$UnknownAppInfoExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
