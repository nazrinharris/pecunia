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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  String get creatorUid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Description get transactionDescription => throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  FundDetails get fundDetails => throw _privateConstructorUsedError;
  TransferDetails? get transferDetails => throw _privateConstructorUsedError;

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
      Description transactionDescription,
      DateTime transactionDate,
      String accountId,
      FundDetails fundDetails,
      TransferDetails? transferDetails});

  $FundDetailsCopyWith<$Res> get fundDetails;
  $TransferDetailsCopyWith<$Res>? get transferDetails;
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
    Object? transferDetails = freezed,
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
              as Description,
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
      transferDetails: freezed == transferDetails
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FundDetailsCopyWith<$Res> get fundDetails {
    return $FundDetailsCopyWith<$Res>(_value.fundDetails, (value) {
      return _then(_value.copyWith(fundDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransferDetailsCopyWith<$Res>? get transferDetails {
    if (_value.transferDetails == null) {
      return null;
    }

    return $TransferDetailsCopyWith<$Res>(_value.transferDetails!, (value) {
      return _then(_value.copyWith(transferDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String creatorUid,
      String name,
      Description transactionDescription,
      DateTime transactionDate,
      String accountId,
      FundDetails fundDetails,
      TransferDetails? transferDetails});

  @override
  $FundDetailsCopyWith<$Res> get fundDetails;
  @override
  $TransferDetailsCopyWith<$Res>? get transferDetails;
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
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
    Object? transferDetails = freezed,
  }) {
    return _then(_$TransactionImpl(
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
              as Description,
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
      transferDetails: freezed == transferDetails
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails?,
    ));
  }
}

/// @nodoc

class _$TransactionImpl extends _Transaction with DiagnosticableTreeMixin {
  const _$TransactionImpl(
      {required this.id,
      required this.creatorUid,
      required this.name,
      required this.transactionDescription,
      required this.transactionDate,
      required this.accountId,
      required this.fundDetails,
      required this.transferDetails})
      : super._();

  @override
  final String id;
  @override
  final String creatorUid;
  @override
  final String name;
  @override
  final Description transactionDescription;
  @override
  final DateTime transactionDate;
  @override
  final String accountId;
  @override
  final FundDetails fundDetails;
  @override
  final TransferDetails? transferDetails;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transaction(id: $id, creatorUid: $creatorUid, name: $name, transactionDescription: $transactionDescription, transactionDate: $transactionDate, accountId: $accountId, fundDetails: $fundDetails, transferDetails: $transferDetails)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transaction'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('creatorUid', creatorUid))
      ..add(DiagnosticsProperty('name', name))
      ..add(
          DiagnosticsProperty('transactionDescription', transactionDescription))
      ..add(DiagnosticsProperty('transactionDate', transactionDate))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('fundDetails', fundDetails))
      ..add(DiagnosticsProperty('transferDetails', transferDetails));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
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
                other.fundDetails == fundDetails) &&
            (identical(other.transferDetails, transferDetails) ||
                other.transferDetails == transferDetails));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      creatorUid,
      name,
      transactionDescription,
      transactionDate,
      accountId,
      fundDetails,
      transferDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {required final String id,
      required final String creatorUid,
      required final String name,
      required final Description transactionDescription,
      required final DateTime transactionDate,
      required final String accountId,
      required final FundDetails fundDetails,
      required final TransferDetails? transferDetails}) = _$TransactionImpl;
  const _Transaction._() : super._();

  @override
  String get id;
  @override
  String get creatorUid;
  @override
  String get name;
  @override
  Description get transactionDescription;
  @override
  DateTime get transactionDate;
  @override
  String get accountId;
  @override
  FundDetails get fundDetails;
  @override
  TransferDetails? get transferDetails;
  @override
  @JsonKey(ignore: true)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
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
abstract class _$$FundDetailsImplCopyWith<$Res>
    implements $FundDetailsCopyWith<$Res> {
  factory _$$FundDetailsImplCopyWith(
          _$FundDetailsImpl value, $Res Function(_$FundDetailsImpl) then) =
      __$$FundDetailsImplCopyWithImpl<$Res>;
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
class __$$FundDetailsImplCopyWithImpl<$Res>
    extends _$FundDetailsCopyWithImpl<$Res, _$FundDetailsImpl>
    implements _$$FundDetailsImplCopyWith<$Res> {
  __$$FundDetailsImplCopyWithImpl(
      _$FundDetailsImpl _value, $Res Function(_$FundDetailsImpl) _then)
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
    return _then(_$FundDetailsImpl(
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

class _$FundDetailsImpl extends _FundDetails with DiagnosticableTreeMixin {
  const _$FundDetailsImpl(
      {required this.baseAmount,
      required this.baseCurrency,
      required this.transactionType,
      required this.exchangeRate,
      required this.targetAmount,
      required this.targetCurrency})
      : assert(
            exchangeRate != null &&
                    targetAmount != null &&
                    targetCurrency != null ||
                exchangeRate == null &&
                    targetAmount == null &&
                    targetCurrency == null,
            'Invalid multi-currency fields. Either provide all fields or none'),
        super._();

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FundDetails(baseAmount: $baseAmount, baseCurrency: $baseCurrency, transactionType: $transactionType, exchangeRate: $exchangeRate, targetAmount: $targetAmount, targetCurrency: $targetCurrency)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FundDetails'))
      ..add(DiagnosticsProperty('baseAmount', baseAmount))
      ..add(DiagnosticsProperty('baseCurrency', baseCurrency))
      ..add(DiagnosticsProperty('transactionType', transactionType))
      ..add(DiagnosticsProperty('exchangeRate', exchangeRate))
      ..add(DiagnosticsProperty('targetAmount', targetAmount))
      ..add(DiagnosticsProperty('targetCurrency', targetCurrency));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FundDetailsImpl &&
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
  _$$FundDetailsImplCopyWith<_$FundDetailsImpl> get copyWith =>
      __$$FundDetailsImplCopyWithImpl<_$FundDetailsImpl>(this, _$identity);
}

abstract class _FundDetails extends FundDetails {
  const factory _FundDetails(
      {required final double baseAmount,
      required final Currency baseCurrency,
      required final TransactionType transactionType,
      required final double? exchangeRate,
      required final double? targetAmount,
      required final Currency? targetCurrency}) = _$FundDetailsImpl;
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
  _$$FundDetailsImplCopyWith<_$FundDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransferDetails {
  String get linkedAccountId => throw _privateConstructorUsedError;
  String get linkedTransactionId => throw _privateConstructorUsedError;
  TransferDescription get transferDescription =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferDetailsCopyWith<TransferDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferDetailsCopyWith<$Res> {
  factory $TransferDetailsCopyWith(
          TransferDetails value, $Res Function(TransferDetails) then) =
      _$TransferDetailsCopyWithImpl<$Res, TransferDetails>;
  @useResult
  $Res call(
      {String linkedAccountId,
      String linkedTransactionId,
      TransferDescription transferDescription});
}

/// @nodoc
class _$TransferDetailsCopyWithImpl<$Res, $Val extends TransferDetails>
    implements $TransferDetailsCopyWith<$Res> {
  _$TransferDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? linkedAccountId = null,
    Object? linkedTransactionId = null,
    Object? transferDescription = null,
  }) {
    return _then(_value.copyWith(
      linkedAccountId: null == linkedAccountId
          ? _value.linkedAccountId
          : linkedAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      linkedTransactionId: null == linkedTransactionId
          ? _value.linkedTransactionId
          : linkedTransactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transferDescription: null == transferDescription
          ? _value.transferDescription
          : transferDescription // ignore: cast_nullable_to_non_nullable
              as TransferDescription,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferDetailsImplCopyWith<$Res>
    implements $TransferDetailsCopyWith<$Res> {
  factory _$$TransferDetailsImplCopyWith(_$TransferDetailsImpl value,
          $Res Function(_$TransferDetailsImpl) then) =
      __$$TransferDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String linkedAccountId,
      String linkedTransactionId,
      TransferDescription transferDescription});
}

/// @nodoc
class __$$TransferDetailsImplCopyWithImpl<$Res>
    extends _$TransferDetailsCopyWithImpl<$Res, _$TransferDetailsImpl>
    implements _$$TransferDetailsImplCopyWith<$Res> {
  __$$TransferDetailsImplCopyWithImpl(
      _$TransferDetailsImpl _value, $Res Function(_$TransferDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? linkedAccountId = null,
    Object? linkedTransactionId = null,
    Object? transferDescription = null,
  }) {
    return _then(_$TransferDetailsImpl(
      linkedAccountId: null == linkedAccountId
          ? _value.linkedAccountId
          : linkedAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      linkedTransactionId: null == linkedTransactionId
          ? _value.linkedTransactionId
          : linkedTransactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transferDescription: null == transferDescription
          ? _value.transferDescription
          : transferDescription // ignore: cast_nullable_to_non_nullable
              as TransferDescription,
    ));
  }
}

/// @nodoc

class _$TransferDetailsImpl extends _TransferDetails
    with DiagnosticableTreeMixin {
  const _$TransferDetailsImpl(
      {required this.linkedAccountId,
      required this.linkedTransactionId,
      required this.transferDescription})
      : assert(
            linkedAccountId != null && linkedTransactionId != null ||
                linkedAccountId == null && linkedTransactionId == null,
            'Either provide all fields or none'),
        super._();

  @override
  final String linkedAccountId;
  @override
  final String linkedTransactionId;
  @override
  final TransferDescription transferDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransferDetails(linkedAccountId: $linkedAccountId, linkedTransactionId: $linkedTransactionId, transferDescription: $transferDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransferDetails'))
      ..add(DiagnosticsProperty('linkedAccountId', linkedAccountId))
      ..add(DiagnosticsProperty('linkedTransactionId', linkedTransactionId))
      ..add(DiagnosticsProperty('transferDescription', transferDescription));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferDetailsImpl &&
            (identical(other.linkedAccountId, linkedAccountId) ||
                other.linkedAccountId == linkedAccountId) &&
            (identical(other.linkedTransactionId, linkedTransactionId) ||
                other.linkedTransactionId == linkedTransactionId) &&
            (identical(other.transferDescription, transferDescription) ||
                other.transferDescription == transferDescription));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, linkedAccountId, linkedTransactionId, transferDescription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferDetailsImplCopyWith<_$TransferDetailsImpl> get copyWith =>
      __$$TransferDetailsImplCopyWithImpl<_$TransferDetailsImpl>(
          this, _$identity);
}

abstract class _TransferDetails extends TransferDetails {
  const factory _TransferDetails(
          {required final String linkedAccountId,
          required final String linkedTransactionId,
          required final TransferDescription transferDescription}) =
      _$TransferDetailsImpl;
  const _TransferDetails._() : super._();

  @override
  String get linkedAccountId;
  @override
  String get linkedTransactionId;
  @override
  TransferDescription get transferDescription;
  @override
  @JsonKey(ignore: true)
  _$$TransferDetailsImplCopyWith<_$TransferDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
