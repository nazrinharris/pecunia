// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CriticalException {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CriticalExceptionCopyWith<CriticalException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CriticalExceptionCopyWith<$Res> {
  factory $CriticalExceptionCopyWith(
          CriticalException value, $Res Function(CriticalException) then) =
      _$CriticalExceptionCopyWithImpl<$Res, CriticalException>;
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class _$CriticalExceptionCopyWithImpl<$Res, $Val extends CriticalException>
    implements $CriticalExceptionCopyWith<$Res> {
  _$CriticalExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CriticalExceptionImplCopyWith<$Res>
    implements $CriticalExceptionCopyWith<$Res> {
  factory _$$CriticalExceptionImplCopyWith(_$CriticalExceptionImpl value,
          $Res Function(_$CriticalExceptionImpl) then) =
      __$$CriticalExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StackTrace stackTrace, String? message});
}

/// @nodoc
class __$$CriticalExceptionImplCopyWithImpl<$Res>
    extends _$CriticalExceptionCopyWithImpl<$Res, _$CriticalExceptionImpl>
    implements _$$CriticalExceptionImplCopyWith<$Res> {
  __$$CriticalExceptionImplCopyWithImpl(_$CriticalExceptionImpl _value,
      $Res Function(_$CriticalExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = freezed,
  }) {
    return _then(_$CriticalExceptionImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CriticalExceptionImpl implements _CriticalException {
  _$CriticalExceptionImpl(
      {required this.stackTrace,
      this.message = 'This operation should never fail'});

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'CriticalException(stackTrace: $stackTrace, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CriticalExceptionImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CriticalExceptionImplCopyWith<_$CriticalExceptionImpl> get copyWith =>
      __$$CriticalExceptionImplCopyWithImpl<_$CriticalExceptionImpl>(
          this, _$identity);
}

abstract class _CriticalException implements CriticalException {
  factory _CriticalException(
      {required final StackTrace stackTrace,
      final String? message}) = _$CriticalExceptionImpl;

  @override
  StackTrace get stackTrace;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$CriticalExceptionImplCopyWith<_$CriticalExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
