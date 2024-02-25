// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EntryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Option<bool> maybeIsFirstOpen) noLoggedInUser,
    required TResult Function() completedEntry,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult? Function()? completedEntry,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult Function()? completedEntry,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoLoggedInUser value) noLoggedInUser,
    required TResult Function(_CompletedEntry value) completedEntry,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult? Function(_CompletedEntry value)? completedEntry,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult Function(_CompletedEntry value)? completedEntry,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryStateCopyWith<$Res> {
  factory $EntryStateCopyWith(
          EntryState value, $Res Function(EntryState) then) =
      _$EntryStateCopyWithImpl<$Res, EntryState>;
}

/// @nodoc
class _$EntryStateCopyWithImpl<$Res, $Val extends EntryState>
    implements $EntryStateCopyWith<$Res> {
  _$EntryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$EntryStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl extends _Loading {
  const _$LoadingImpl() : super._();

  @override
  String toString() {
    return 'EntryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Option<bool> maybeIsFirstOpen) noLoggedInUser,
    required TResult Function() completedEntry,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult? Function()? completedEntry,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult Function()? completedEntry,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoLoggedInUser value) noLoggedInUser,
    required TResult Function(_CompletedEntry value) completedEntry,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult? Function(_CompletedEntry value)? completedEntry,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult Function(_CompletedEntry value)? completedEntry,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends EntryState {
  const factory _Loading() = _$LoadingImpl;
  const _Loading._() : super._();
}

/// @nodoc
abstract class _$$NoLoggedInUserImplCopyWith<$Res> {
  factory _$$NoLoggedInUserImplCopyWith(_$NoLoggedInUserImpl value,
          $Res Function(_$NoLoggedInUserImpl) then) =
      __$$NoLoggedInUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Option<bool> maybeIsFirstOpen});
}

/// @nodoc
class __$$NoLoggedInUserImplCopyWithImpl<$Res>
    extends _$EntryStateCopyWithImpl<$Res, _$NoLoggedInUserImpl>
    implements _$$NoLoggedInUserImplCopyWith<$Res> {
  __$$NoLoggedInUserImplCopyWithImpl(
      _$NoLoggedInUserImpl _value, $Res Function(_$NoLoggedInUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maybeIsFirstOpen = null,
  }) {
    return _then(_$NoLoggedInUserImpl(
      null == maybeIsFirstOpen
          ? _value.maybeIsFirstOpen
          : maybeIsFirstOpen // ignore: cast_nullable_to_non_nullable
              as Option<bool>,
    ));
  }
}

/// @nodoc

class _$NoLoggedInUserImpl extends _NoLoggedInUser {
  const _$NoLoggedInUserImpl(this.maybeIsFirstOpen) : super._();

  @override
  final Option<bool> maybeIsFirstOpen;

  @override
  String toString() {
    return 'EntryState.noLoggedInUser(maybeIsFirstOpen: $maybeIsFirstOpen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoLoggedInUserImpl &&
            (identical(other.maybeIsFirstOpen, maybeIsFirstOpen) ||
                other.maybeIsFirstOpen == maybeIsFirstOpen));
  }

  @override
  int get hashCode => Object.hash(runtimeType, maybeIsFirstOpen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoLoggedInUserImplCopyWith<_$NoLoggedInUserImpl> get copyWith =>
      __$$NoLoggedInUserImplCopyWithImpl<_$NoLoggedInUserImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Option<bool> maybeIsFirstOpen) noLoggedInUser,
    required TResult Function() completedEntry,
    required TResult Function(Failure failure) error,
  }) {
    return noLoggedInUser(maybeIsFirstOpen);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult? Function()? completedEntry,
    TResult? Function(Failure failure)? error,
  }) {
    return noLoggedInUser?.call(maybeIsFirstOpen);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult Function()? completedEntry,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (noLoggedInUser != null) {
      return noLoggedInUser(maybeIsFirstOpen);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoLoggedInUser value) noLoggedInUser,
    required TResult Function(_CompletedEntry value) completedEntry,
    required TResult Function(_Error value) error,
  }) {
    return noLoggedInUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult? Function(_CompletedEntry value)? completedEntry,
    TResult? Function(_Error value)? error,
  }) {
    return noLoggedInUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult Function(_CompletedEntry value)? completedEntry,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (noLoggedInUser != null) {
      return noLoggedInUser(this);
    }
    return orElse();
  }
}

abstract class _NoLoggedInUser extends EntryState {
  const factory _NoLoggedInUser(final Option<bool> maybeIsFirstOpen) =
      _$NoLoggedInUserImpl;
  const _NoLoggedInUser._() : super._();

  Option<bool> get maybeIsFirstOpen;
  @JsonKey(ignore: true)
  _$$NoLoggedInUserImplCopyWith<_$NoLoggedInUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompletedEntryImplCopyWith<$Res> {
  factory _$$CompletedEntryImplCopyWith(_$CompletedEntryImpl value,
          $Res Function(_$CompletedEntryImpl) then) =
      __$$CompletedEntryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedEntryImplCopyWithImpl<$Res>
    extends _$EntryStateCopyWithImpl<$Res, _$CompletedEntryImpl>
    implements _$$CompletedEntryImplCopyWith<$Res> {
  __$$CompletedEntryImplCopyWithImpl(
      _$CompletedEntryImpl _value, $Res Function(_$CompletedEntryImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CompletedEntryImpl extends _CompletedEntry {
  const _$CompletedEntryImpl() : super._();

  @override
  String toString() {
    return 'EntryState.completedEntry()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedEntryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Option<bool> maybeIsFirstOpen) noLoggedInUser,
    required TResult Function() completedEntry,
    required TResult Function(Failure failure) error,
  }) {
    return completedEntry();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult? Function()? completedEntry,
    TResult? Function(Failure failure)? error,
  }) {
    return completedEntry?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult Function()? completedEntry,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (completedEntry != null) {
      return completedEntry();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoLoggedInUser value) noLoggedInUser,
    required TResult Function(_CompletedEntry value) completedEntry,
    required TResult Function(_Error value) error,
  }) {
    return completedEntry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult? Function(_CompletedEntry value)? completedEntry,
    TResult? Function(_Error value)? error,
  }) {
    return completedEntry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult Function(_CompletedEntry value)? completedEntry,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (completedEntry != null) {
      return completedEntry(this);
    }
    return orElse();
  }
}

abstract class _CompletedEntry extends EntryState {
  const factory _CompletedEntry() = _$CompletedEntryImpl;
  const _CompletedEntry._() : super._();
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$EntryStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$ErrorImpl extends _Error {
  const _$ErrorImpl(this.failure) : super._();

  @override
  final Failure failure;

  @override
  String toString() {
    return 'EntryState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Option<bool> maybeIsFirstOpen) noLoggedInUser,
    required TResult Function() completedEntry,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult? Function()? completedEntry,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Option<bool> maybeIsFirstOpen)? noLoggedInUser,
    TResult Function()? completedEntry,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_NoLoggedInUser value) noLoggedInUser,
    required TResult Function(_CompletedEntry value) completedEntry,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult? Function(_CompletedEntry value)? completedEntry,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_NoLoggedInUser value)? noLoggedInUser,
    TResult Function(_CompletedEntry value)? completedEntry,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error extends EntryState {
  const factory _Error(final Failure failure) = _$ErrorImpl;
  const _Error._() : super._();

  Failure get failure;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
