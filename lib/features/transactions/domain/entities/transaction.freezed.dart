// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  String get creatorUid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TransactionDescription get transactionDescription =>
      throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  FundDetails get fundDetails => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {String id,
      String creatorUid,
      String name,
      TransactionDescription transactionDescription,
      DateTime transactionDate,
      String accountId,
      FundDetails fundDetails});

  $FundDetailsCopyWith<$Res> get fundDetails;
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

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
    Object? transactionDescription = null,
    Object? transactionDate = null,
    Object? accountId = null,
    Object? fundDetails = null,
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
      transactionDescription: null == transactionDescription
          ? _value.transactionDescription
          : transactionDescription // ignore: cast_nullable_to_non_nullable
              as TransactionDescription,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      fundDetails: null == fundDetails
          ? _value.fundDetails
          : fundDetails // ignore: cast_nullable_to_non_nullable
              as FundDetails,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FundDetailsCopyWith<$Res> get fundDetails {
    return $FundDetailsCopyWith<$Res>(_value.fundDetails, (value) {
      return _then(_value.copyWith(fundDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$_TransactionCopyWith(
          _$_Transaction value, $Res Function(_$_Transaction) then) =
      __$$_TransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorUid,
      String name,
      TransactionDescription transactionDescription,
      DateTime transactionDate,
      String accountId,
      FundDetails fundDetails});

  @override
  $FundDetailsCopyWith<$Res> get fundDetails;
}

/// @nodoc
class __$$_TransactionCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$_Transaction>
    implements _$$_TransactionCopyWith<$Res> {
  __$$_TransactionCopyWithImpl(
      _$_Transaction _value, $Res Function(_$_Transaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? creatorUid = null,
    Object? name = null,
    Object? transactionDescription = null,
    Object? transactionDate = null,
    Object? accountId = null,
    Object? fundDetails = null,
  }) {
    return _then(_$_Transaction(
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
      transactionDescription: null == transactionDescription
          ? _value.transactionDescription
          : transactionDescription // ignore: cast_nullable_to_non_nullable
              as TransactionDescription,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      fundDetails: null == fundDetails
          ? _value.fundDetails
          : fundDetails // ignore: cast_nullable_to_non_nullable
              as FundDetails,
    ));
  }
}

/// @nodoc

class _$_Transaction extends _Transaction {
  const _$_Transaction(
      {required this.id,
      required this.creatorUid,
      required this.name,
      required this.transactionDescription,
      required this.transactionDate,
      required this.accountId,
      required this.fundDetails})
      : super._();

  @override
  final String id;
  @override
  final String creatorUid;
  @override
  final String name;
  @override
  final TransactionDescription transactionDescription;
  @override
  final DateTime transactionDate;
  @override
  final String accountId;
  @override
  final FundDetails fundDetails;

  @override
  String toString() {
    return 'Transaction(id: $id, creatorUid: $creatorUid, name: $name, transactionDescription: $transactionDescription, transactionDate: $transactionDate, accountId: $accountId, fundDetails: $fundDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorUid, creatorUid) ||
                other.creatorUid == creatorUid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.transactionDescription, transactionDescription) ||
                other.transactionDescription == transactionDescription) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.fundDetails, fundDetails) ||
                other.fundDetails == fundDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, creatorUid, name,
      transactionDescription, transactionDate, accountId, fundDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      __$$_TransactionCopyWithImpl<_$_Transaction>(this, _$identity);
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {required final String id,
      required final String creatorUid,
      required final String name,
      required final TransactionDescription transactionDescription,
      required final DateTime transactionDate,
      required final String accountId,
      required final FundDetails fundDetails}) = _$_Transaction;
  const _Transaction._() : super._();

  @override
  String get id;
  @override
  String get creatorUid;
  @override
  String get name;
  @override
  TransactionDescription get transactionDescription;
  @override
  DateTime get transactionDate;
  @override
  String get accountId;
  @override
  FundDetails get fundDetails;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FundDetails {
  double get baseAmount => throw _privateConstructorUsedError;
  Currency get baseCurrency => throw _privateConstructorUsedError;
  TransactionType get transactionType => throw _privateConstructorUsedError;
  double? get exchangeRate => throw _privateConstructorUsedError;
  double? get targetAmount => throw _privateConstructorUsedError;
  Currency? get targetCurrency => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FundDetailsCopyWith<FundDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FundDetailsCopyWith<$Res> {
  factory $FundDetailsCopyWith(
          FundDetails value, $Res Function(FundDetails) then) =
      _$FundDetailsCopyWithImpl<$Res, FundDetails>;
  @useResult
  $Res call(
      {double baseAmount,
      Currency baseCurrency,
      TransactionType transactionType,
      double? exchangeRate,
      double? targetAmount,
      Currency? targetCurrency});
}

/// @nodoc
class _$FundDetailsCopyWithImpl<$Res, $Val extends FundDetails>
    implements $FundDetailsCopyWith<$Res> {
  _$FundDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseAmount = null,
    Object? baseCurrency = null,
    Object? transactionType = null,
    Object? exchangeRate = freezed,
    Object? targetAmount = freezed,
    Object? targetCurrency = freezed,
  }) {
    return _then(_value.copyWith(
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      baseCurrency: null == baseCurrency
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      targetAmount: freezed == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      targetCurrency: freezed == targetCurrency
          ? _value.targetCurrency
          : targetCurrency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FundDetailsCopyWith<$Res>
    implements $FundDetailsCopyWith<$Res> {
  factory _$$_FundDetailsCopyWith(
          _$_FundDetails value, $Res Function(_$_FundDetails) then) =
      __$$_FundDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double baseAmount,
      Currency baseCurrency,
      TransactionType transactionType,
      double? exchangeRate,
      double? targetAmount,
      Currency? targetCurrency});
}

/// @nodoc
class __$$_FundDetailsCopyWithImpl<$Res>
    extends _$FundDetailsCopyWithImpl<$Res, _$_FundDetails>
    implements _$$_FundDetailsCopyWith<$Res> {
  __$$_FundDetailsCopyWithImpl(
      _$_FundDetails _value, $Res Function(_$_FundDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseAmount = null,
    Object? baseCurrency = null,
    Object? transactionType = null,
    Object? exchangeRate = freezed,
    Object? targetAmount = freezed,
    Object? targetCurrency = freezed,
  }) {
    return _then(_$_FundDetails(
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      baseCurrency: null == baseCurrency
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      targetAmount: freezed == targetAmount
          ? _value.targetAmount
          : targetAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      targetCurrency: freezed == targetCurrency
          ? _value.targetCurrency
          : targetCurrency // ignore: cast_nullable_to_non_nullable
              as Currency?,
    ));
  }
}

/// @nodoc

class _$_FundDetails extends _FundDetails {
  const _$_FundDetails(
      {required this.baseAmount,
      required this.baseCurrency,
      required this.transactionType,
      required this.exchangeRate,
      required this.targetAmount,
      required this.targetCurrency})
      : super._();

  @override
  final double baseAmount;
  @override
  final Currency baseCurrency;
  @override
  final TransactionType transactionType;
  @override
  final double? exchangeRate;
  @override
  final double? targetAmount;
  @override
  final Currency? targetCurrency;

  @override
  String toString() {
    return 'FundDetails(baseAmount: $baseAmount, baseCurrency: $baseCurrency, transactionType: $transactionType, exchangeRate: $exchangeRate, targetAmount: $targetAmount, targetCurrency: $targetCurrency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FundDetails &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.baseCurrency, baseCurrency) ||
                other.baseCurrency == baseCurrency) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.targetCurrency, targetCurrency) ||
                other.targetCurrency == targetCurrency));
  }

  @override
  int get hashCode => Object.hash(runtimeType, baseAmount, baseCurrency,
      transactionType, exchangeRate, targetAmount, targetCurrency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FundDetailsCopyWith<_$_FundDetails> get copyWith =>
      __$$_FundDetailsCopyWithImpl<_$_FundDetails>(this, _$identity);
}

abstract class _FundDetails extends FundDetails {
  const factory _FundDetails(
      {required final double baseAmount,
      required final Currency baseCurrency,
      required final TransactionType transactionType,
      required final double? exchangeRate,
      required final double? targetAmount,
      required final Currency? targetCurrency}) = _$_FundDetails;
  const _FundDetails._() : super._();

  @override
  double get baseAmount;
  @override
  Currency get baseCurrency;
  @override
  TransactionType get transactionType;
  @override
  double? get exchangeRate;
  @override
  double? get targetAmount;
  @override
  Currency? get targetCurrency;
  @override
  @JsonKey(ignore: true)
  _$$_FundDetailsCopyWith<_$_FundDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
