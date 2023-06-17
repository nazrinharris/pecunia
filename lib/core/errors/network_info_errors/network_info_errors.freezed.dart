// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_info_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NetworkInfoFailure {
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  NetworkInfoErrorType get errorType => throw _privateConstructorUsedError;
  Object? get rawException => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworkInfoFailureCopyWith<NetworkInfoFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkInfoFailureCopyWith<$Res> {
  factory $NetworkInfoFailureCopyWith(
          NetworkInfoFailure value, $Res Function(NetworkInfoFailure) then) =
      _$NetworkInfoFailureCopyWithImpl<$Res, NetworkInfoFailure>;
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      NetworkInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class _$NetworkInfoFailureCopyWithImpl<$Res, $Val extends NetworkInfoFailure>
    implements $NetworkInfoFailureCopyWith<$Res> {
  _$NetworkInfoFailureCopyWithImpl(this._value, this._then);

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
              as NetworkInfoErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NetworkInfoFailureCopyWith<$Res>
    implements $NetworkInfoFailureCopyWith<$Res> {
  factory _$$_NetworkInfoFailureCopyWith(_$_NetworkInfoFailure value,
          $Res Function(_$_NetworkInfoFailure) then) =
      __$$_NetworkInfoFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackTrace stackTrace,
      String message,
      NetworkInfoErrorType errorType,
      Object? rawException});
}

/// @nodoc
class __$$_NetworkInfoFailureCopyWithImpl<$Res>
    extends _$NetworkInfoFailureCopyWithImpl<$Res, _$_NetworkInfoFailure>
    implements _$$_NetworkInfoFailureCopyWith<$Res> {
  __$$_NetworkInfoFailureCopyWithImpl(
      _$_NetworkInfoFailure _value, $Res Function(_$_NetworkInfoFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
    Object? message = null,
    Object? errorType = null,
    Object? rawException = freezed,
  }) {
    return _then(_$_NetworkInfoFailure(
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
              as NetworkInfoErrorType,
      rawException:
          freezed == rawException ? _value.rawException : rawException,
    ));
  }
}

/// @nodoc

class _$_NetworkInfoFailure extends _NetworkInfoFailure {
  const _$_NetworkInfoFailure(
      {required this.stackTrace,
      this.message = defaultUnknownNetworkInfoErrorMessage,
      this.errorType = NetworkInfoErrorType.unknownNetworkInfoError,
      this.rawException})
      : super._();

  @override
  final StackTrace stackTrace;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final NetworkInfoErrorType errorType;
  @override
  final Object? rawException;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NetworkInfoFailureCopyWith<_$_NetworkInfoFailure> get copyWith =>
      __$$_NetworkInfoFailureCopyWithImpl<_$_NetworkInfoFailure>(
          this, _$identity);
}

abstract class _NetworkInfoFailure extends NetworkInfoFailure {
  const factory _NetworkInfoFailure(
      {required final StackTrace stackTrace,
      final String message,
      final NetworkInfoErrorType errorType,
      final Object? rawException}) = _$_NetworkInfoFailure;
  const _NetworkInfoFailure._() : super._();

  @override
  StackTrace get stackTrace;
  @override
  String get message;
  @override
  NetworkInfoErrorType get errorType;
  @override
  Object? get rawException;
  @override
  @JsonKey(ignore: true)
  _$$_NetworkInfoFailureCopyWith<_$_NetworkInfoFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
