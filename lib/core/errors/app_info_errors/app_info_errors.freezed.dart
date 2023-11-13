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
abstract class _$$_AppInfoFailureCopyWith<$Res>
    implements $AppInfoFailureCopyWith<$Res> {
  factory _$$_AppInfoFailureCopyWith(
          _$_AppInfoFailure value, $Res Function(_$_AppInfoFailure) then) =
      __$$_AppInfoFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AppInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_AppInfoFailureCopyWithImpl<$Res>
    extends _$AppInfoFailureCopyWithImpl<$Res, _$_AppInfoFailure>
    implements _$$_AppInfoFailureCopyWith<$Res> {
  __$$_AppInfoFailureCopyWithImpl(
      _$_AppInfoFailure _value, $Res Function(_$_AppInfoFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_AppInfoFailure(
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

class _$_AppInfoFailure extends _AppInfoFailure {
  const _$_AppInfoFailure(
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
  _$$_AppInfoFailureCopyWith<_$_AppInfoFailure> get copyWith =>
      __$$_AppInfoFailureCopyWithImpl<_$_AppInfoFailure>(this, _$identity);

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
      final Object? rawException}) = _$_AppInfoFailure;
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
  _$$_AppInfoFailureCopyWith<_$_AppInfoFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownAppInfoFailureCopyWith<$Res>
    implements $AppInfoFailureCopyWith<$Res> {
  factory _$$_UnknownAppInfoFailureCopyWith(_$_UnknownAppInfoFailure value,
          $Res Function(_$_UnknownAppInfoFailure) then) =
      __$$_UnknownAppInfoFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      AppInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_UnknownAppInfoFailureCopyWithImpl<$Res>
    extends _$AppInfoFailureCopyWithImpl<$Res, _$_UnknownAppInfoFailure>
    implements _$$_UnknownAppInfoFailureCopyWith<$Res> {
  __$$_UnknownAppInfoFailureCopyWithImpl(_$_UnknownAppInfoFailure _value,
      $Res Function(_$_UnknownAppInfoFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_UnknownAppInfoFailure(
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

class _$_UnknownAppInfoFailure extends _UnknownAppInfoFailure {
  const _$_UnknownAppInfoFailure(
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
  _$$_UnknownAppInfoFailureCopyWith<_$_UnknownAppInfoFailure> get copyWith =>
      __$$_UnknownAppInfoFailureCopyWithImpl<_$_UnknownAppInfoFailure>(
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
      final Object? rawException}) = _$_UnknownAppInfoFailure;
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
  _$$_UnknownAppInfoFailureCopyWith<_$_UnknownAppInfoFailure> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$_AppInfoExceptionCopyWith<$Res>
    implements $AppInfoExceptionCopyWith<$Res> {
  factory _$$_AppInfoExceptionCopyWith(
          _$_AppInfoException value, $Res Function(_$_AppInfoException) then) =
      __$$_AppInfoExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AppInfoErrorType errorType, String? message});
}

/// @nodoc
class __$$_AppInfoExceptionCopyWithImpl<$Res>
    extends _$AppInfoExceptionCopyWithImpl<$Res, _$_AppInfoException>
    implements _$$_AppInfoExceptionCopyWith<$Res> {
  __$$_AppInfoExceptionCopyWithImpl(
      _$_AppInfoException _value, $Res Function(_$_AppInfoException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$_AppInfoException(
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

class _$_AppInfoException extends _AppInfoException {
  _$_AppInfoException(
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
            other is _$_AppInfoException &&
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
  _$$_AppInfoExceptionCopyWith<_$_AppInfoException> get copyWith =>
      __$$_AppInfoExceptionCopyWithImpl<_$_AppInfoException>(this, _$identity);

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
      final String? message}) = _$_AppInfoException;
  _AppInfoException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AppInfoErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_AppInfoExceptionCopyWith<_$_AppInfoException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownAppInfoExceptionCopyWith<$Res>
    implements $AppInfoExceptionCopyWith<$Res> {
  factory _$$_UnknownAppInfoExceptionCopyWith(_$_UnknownAppInfoException value,
          $Res Function(_$_UnknownAppInfoException) then) =
      __$$_UnknownAppInfoExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace, AppInfoErrorType errorType, String? message});
}

/// @nodoc
class __$$_UnknownAppInfoExceptionCopyWithImpl<$Res>
    extends _$AppInfoExceptionCopyWithImpl<$Res, _$_UnknownAppInfoException>
    implements _$$_UnknownAppInfoExceptionCopyWith<$Res> {
  __$$_UnknownAppInfoExceptionCopyWithImpl(_$_UnknownAppInfoException _value,
      $Res Function(_$_UnknownAppInfoException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? errorType = null,
    Object? message = freezed,
  }) {
    return _then(_$_UnknownAppInfoException(
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

class _$_UnknownAppInfoException extends _UnknownAppInfoException {
  _$_UnknownAppInfoException(
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
            other is _$_UnknownAppInfoException &&
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
  _$$_UnknownAppInfoExceptionCopyWith<_$_UnknownAppInfoException>
      get copyWith =>
          __$$_UnknownAppInfoExceptionCopyWithImpl<_$_UnknownAppInfoException>(
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
      final String? message}) = _$_UnknownAppInfoException;
  _UnknownAppInfoException._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  AppInfoErrorType get errorType;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownAppInfoExceptionCopyWith<_$_UnknownAppInfoException>
      get copyWith => throw _privateConstructorUsedError;
}
