// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Account {
  String get id =>
      throw _privateConstructorUsedError; // Unique identifier for the account
  String get creatorUid =>
      throw _privateConstructorUsedError; // The uid of the user who created the account
  String get name =>
      throw _privateConstructorUsedError; // The name of the account
  double get initialBalance =>
      throw _privateConstructorUsedError; // The initial balance when the account was created
  double get balance =>
      throw _privateConstructorUsedError; // The current balance of the account
  String get currency =>
      throw _privateConstructorUsedError; // The currency used by the account
  DateTime get createdOn =>
      throw _privateConstructorUsedError; // The date when the account was created
  AccountDescription get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {String id,
      String creatorUid,
      String name,
      double initialBalance,
      double balance,
      String currency,
      DateTime createdOn,
      AccountDescription description});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorUid = null,
    Object? name = null,
    Object? initialBalance = null,
    Object? balance = null,
    Object? currency = null,
    Object? createdOn = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      initialBalance: null == initialBalance
          ? _value.initialBalance
          : initialBalance // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as AccountDescription,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$_AccountCopyWith(
          _$_Account value, $Res Function(_$_Account) then) =
      __$$_AccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorUid,
      String name,
      double initialBalance,
      double balance,
      String currency,
      DateTime createdOn,
      AccountDescription description});
}

/// @nodoc
class __$$_AccountCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$_Account>
    implements _$$_AccountCopyWith<$Res> {
  __$$_AccountCopyWithImpl(_$_Account _value, $Res Function(_$_Account) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorUid = null,
    Object? name = null,
    Object? initialBalance = null,
    Object? balance = null,
    Object? currency = null,
    Object? createdOn = null,
    Object? description = null,
  }) {
    return _then(_$_Account(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      initialBalance: null == initialBalance
          ? _value.initialBalance
          : initialBalance // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as AccountDescription,
    ));
  }
}

/// @nodoc

class _$_Account extends _Account {
  const _$_Account(
      {required this.id,
      required this.creatorUid,
      required this.name,
      required this.initialBalance,
      required this.balance,
      required this.currency,
      required this.createdOn,
      required this.description})
      : super._();

  @override
  final String id;
// Unique identifier for the account
  @override
  final String creatorUid;
// The uid of the user who created the account
  @override
  final String name;
// The name of the account
  @override
  final double initialBalance;
// The initial balance when the account was created
  @override
  final double balance;
// The current balance of the account
  @override
  final String currency;
// The currency used by the account
  @override
  final DateTime createdOn;
// The date when the account was created
  @override
  final AccountDescription description;

  @override
  String toString() {
    return 'Account(id: $id, creatorUid: $creatorUid, name: $name, initialBalance: $initialBalance, balance: $balance, currency: $currency, createdOn: $createdOn, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Account &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorUid, creatorUid) ||
                other.creatorUid == creatorUid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.initialBalance, initialBalance) ||
                other.initialBalance == initialBalance) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, creatorUid, name,
      initialBalance, balance, currency, createdOn, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      __$$_AccountCopyWithImpl<_$_Account>(this, _$identity);
}

abstract class _Account extends Account {
  const factory _Account(
      {required final String id,
      required final String creatorUid,
      required final String name,
      required final double initialBalance,
      required final double balance,
      required final String currency,
      required final DateTime createdOn,
      required final AccountDescription description}) = _$_Account;
  const _Account._() : super._();

  @override
  String get id;
  @override // Unique identifier for the account
  String get creatorUid;
  @override // The uid of the user who created the account
  String get name;
  @override // The name of the account
  double get initialBalance;
  @override // The initial balance when the account was created
  double get balance;
  @override // The current balance of the account
  String get currency;
  @override // The currency used by the account
  DateTime get createdOn;
  @override // The date when the account was created
  AccountDescription get description;
  @override
  @JsonKey(ignore: true)
  _$$_AccountCopyWith<_$_Account> get copyWith =>
      throw _privateConstructorUsedError;
}
