// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pecunia_drift_db.dart';

// ignore_for_file: type=lint
class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, AccountDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creatorUidMeta =
      const VerificationMeta('creatorUid');
  @override
  late final GeneratedColumn<String> creatorUid = GeneratedColumn<String>(
      'creator_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _initialBalanceMeta =
      const VerificationMeta('initialBalance');
  @override
  late final GeneratedColumn<double> initialBalance = GeneratedColumn<double>(
      'initial_balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'created_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        creatorUid,
        name,
        initialBalance,
        balance,
        currency,
        createdOn,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts_table';
  @override
  VerificationContext validateIntegrity(Insertable<AccountDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('creator_uid')) {
      context.handle(
          _creatorUidMeta,
          creatorUid.isAcceptableOrUnknown(
              data['creator_uid']!, _creatorUidMeta));
    } else if (isInserting) {
      context.missing(_creatorUidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('initial_balance')) {
      context.handle(
          _initialBalanceMeta,
          initialBalance.isAcceptableOrUnknown(
              data['initial_balance']!, _initialBalanceMeta));
    } else if (isInserting) {
      context.missing(_initialBalanceMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('created_on')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta));
    } else if (isInserting) {
      context.missing(_createdOnMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      creatorUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator_uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      initialBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}initial_balance'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_on'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }
}

class AccountDTO extends DataClass implements Insertable<AccountDTO> {
  final String id;
  final String creatorUid;
  final String name;
  final double initialBalance;
  final double balance;
  final String currency;
  final DateTime createdOn;
  final String? description;
  const AccountDTO(
      {required this.id,
      required this.creatorUid,
      required this.name,
      required this.initialBalance,
      required this.balance,
      required this.currency,
      required this.createdOn,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['creator_uid'] = Variable<String>(creatorUid);
    map['name'] = Variable<String>(name);
    map['initial_balance'] = Variable<double>(initialBalance);
    map['balance'] = Variable<double>(balance);
    map['currency'] = Variable<String>(currency);
    map['created_on'] = Variable<DateTime>(createdOn);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      creatorUid: Value(creatorUid),
      name: Value(name),
      initialBalance: Value(initialBalance),
      balance: Value(balance),
      currency: Value(currency),
      createdOn: Value(createdOn),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory AccountDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountDTO(
      id: serializer.fromJson<String>(json['id']),
      creatorUid: serializer.fromJson<String>(json['creatorUid']),
      name: serializer.fromJson<String>(json['name']),
      initialBalance: serializer.fromJson<double>(json['initialBalance']),
      balance: serializer.fromJson<double>(json['balance']),
      currency: serializer.fromJson<String>(json['currency']),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'creatorUid': serializer.toJson<String>(creatorUid),
      'name': serializer.toJson<String>(name),
      'initialBalance': serializer.toJson<double>(initialBalance),
      'balance': serializer.toJson<double>(balance),
      'currency': serializer.toJson<String>(currency),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'description': serializer.toJson<String?>(description),
    };
  }

  AccountDTO copyWith(
          {String? id,
          String? creatorUid,
          String? name,
          double? initialBalance,
          double? balance,
          String? currency,
          DateTime? createdOn,
          Value<String?> description = const Value.absent()}) =>
      AccountDTO(
        id: id ?? this.id,
        creatorUid: creatorUid ?? this.creatorUid,
        name: name ?? this.name,
        initialBalance: initialBalance ?? this.initialBalance,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
        createdOn: createdOn ?? this.createdOn,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('AccountDTO(')
          ..write('id: $id, ')
          ..write('creatorUid: $creatorUid, ')
          ..write('name: $name, ')
          ..write('initialBalance: $initialBalance, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('createdOn: $createdOn, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, creatorUid, name, initialBalance, balance,
      currency, createdOn, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountDTO &&
          other.id == this.id &&
          other.creatorUid == this.creatorUid &&
          other.name == this.name &&
          other.initialBalance == this.initialBalance &&
          other.balance == this.balance &&
          other.currency == this.currency &&
          other.createdOn == this.createdOn &&
          other.description == this.description);
}

class AccountsTableCompanion extends UpdateCompanion<AccountDTO> {
  final Value<String> id;
  final Value<String> creatorUid;
  final Value<String> name;
  final Value<double> initialBalance;
  final Value<double> balance;
  final Value<String> currency;
  final Value<DateTime> createdOn;
  final Value<String?> description;
  final Value<int> rowid;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.creatorUid = const Value.absent(),
    this.name = const Value.absent(),
    this.initialBalance = const Value.absent(),
    this.balance = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    required String id,
    required String creatorUid,
    required String name,
    required double initialBalance,
    required double balance,
    required String currency,
    required DateTime createdOn,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        creatorUid = Value(creatorUid),
        name = Value(name),
        initialBalance = Value(initialBalance),
        balance = Value(balance),
        currency = Value(currency),
        createdOn = Value(createdOn);
  static Insertable<AccountDTO> custom({
    Expression<String>? id,
    Expression<String>? creatorUid,
    Expression<String>? name,
    Expression<double>? initialBalance,
    Expression<double>? balance,
    Expression<String>? currency,
    Expression<DateTime>? createdOn,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creatorUid != null) 'creator_uid': creatorUid,
      if (name != null) 'name': name,
      if (initialBalance != null) 'initial_balance': initialBalance,
      if (balance != null) 'balance': balance,
      if (currency != null) 'currency': currency,
      if (createdOn != null) 'created_on': createdOn,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? creatorUid,
      Value<String>? name,
      Value<double>? initialBalance,
      Value<double>? balance,
      Value<String>? currency,
      Value<DateTime>? createdOn,
      Value<String?>? description,
      Value<int>? rowid}) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      creatorUid: creatorUid ?? this.creatorUid,
      name: name ?? this.name,
      initialBalance: initialBalance ?? this.initialBalance,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      createdOn: createdOn ?? this.createdOn,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creatorUid.present) {
      map['creator_uid'] = Variable<String>(creatorUid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (initialBalance.present) {
      map['initial_balance'] = Variable<double>(initialBalance.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdOn.present) {
      map['created_on'] = Variable<DateTime>(createdOn.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('creatorUid: $creatorUid, ')
          ..write('name: $name, ')
          ..write('initialBalance: $initialBalance, ')
          ..write('balance: $balance, ')
          ..write('currency: $currency, ')
          ..write('createdOn: $createdOn, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creatorUidMeta =
      const VerificationMeta('creatorUid');
  @override
  late final GeneratedColumn<String> creatorUid = GeneratedColumn<String>(
      'creator_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>('transaction_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts_table (id)'));
  static const VerificationMeta _transactionTypeMeta =
      const VerificationMeta('transactionType');
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
      'transaction_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transactionAmountMeta =
      const VerificationMeta('transactionAmount');
  @override
  late final GeneratedColumn<double> transactionAmount =
      GeneratedColumn<double>('transaction_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _baseAmountMeta =
      const VerificationMeta('baseAmount');
  @override
  late final GeneratedColumn<double> baseAmount = GeneratedColumn<double>(
      'base_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _baseCurrencyMeta =
      const VerificationMeta('baseCurrency');
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
      'base_currency', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _exchangeRateMeta =
      const VerificationMeta('exchangeRate');
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
      'exchange_rate', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetAmountMeta =
      const VerificationMeta('targetAmount');
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
      'target_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetCurrencyMeta =
      const VerificationMeta('targetCurrency');
  @override
  late final GeneratedColumn<String> targetCurrency = GeneratedColumn<String>(
      'target_currency', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _linkedTransactionIdMeta =
      const VerificationMeta('linkedTransactionId');
  @override
  late final GeneratedColumn<String> linkedTransactionId =
      GeneratedColumn<String>('linked_transaction_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES transactions_table (id)'));
  static const VerificationMeta _linkedAccountIdMeta =
      const VerificationMeta('linkedAccountId');
  @override
  late final GeneratedColumn<String> linkedAccountId = GeneratedColumn<String>(
      'linked_account_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts_table (id)'));
  static const VerificationMeta _transferDescriptionMeta =
      const VerificationMeta('transferDescription');
  @override
  late final GeneratedColumn<String> transferDescription =
      GeneratedColumn<String>('transfer_description', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 500),
          type: DriftSqlType.string,
          requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        creatorUid,
        name,
        description,
        transactionDate,
        accountId,
        transactionType,
        transactionAmount,
        baseAmount,
        baseCurrency,
        exchangeRate,
        targetAmount,
        targetCurrency,
        linkedTransactionId,
        linkedAccountId,
        transferDescription
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions_table';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('creator_uid')) {
      context.handle(
          _creatorUidMeta,
          creatorUid.isAcceptableOrUnknown(
              data['creator_uid']!, _creatorUidMeta));
    } else if (isInserting) {
      context.missing(_creatorUidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
          _transactionTypeMeta,
          transactionType.isAcceptableOrUnknown(
              data['transaction_type']!, _transactionTypeMeta));
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('transaction_amount')) {
      context.handle(
          _transactionAmountMeta,
          transactionAmount.isAcceptableOrUnknown(
              data['transaction_amount']!, _transactionAmountMeta));
    } else if (isInserting) {
      context.missing(_transactionAmountMeta);
    }
    if (data.containsKey('base_amount')) {
      context.handle(
          _baseAmountMeta,
          baseAmount.isAcceptableOrUnknown(
              data['base_amount']!, _baseAmountMeta));
    } else if (isInserting) {
      context.missing(_baseAmountMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
          _baseCurrencyMeta,
          baseCurrency.isAcceptableOrUnknown(
              data['base_currency']!, _baseCurrencyMeta));
    } else if (isInserting) {
      context.missing(_baseCurrencyMeta);
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
          _exchangeRateMeta,
          exchangeRate.isAcceptableOrUnknown(
              data['exchange_rate']!, _exchangeRateMeta));
    }
    if (data.containsKey('target_amount')) {
      context.handle(
          _targetAmountMeta,
          targetAmount.isAcceptableOrUnknown(
              data['target_amount']!, _targetAmountMeta));
    }
    if (data.containsKey('target_currency')) {
      context.handle(
          _targetCurrencyMeta,
          targetCurrency.isAcceptableOrUnknown(
              data['target_currency']!, _targetCurrencyMeta));
    }
    if (data.containsKey('linked_transaction_id')) {
      context.handle(
          _linkedTransactionIdMeta,
          linkedTransactionId.isAcceptableOrUnknown(
              data['linked_transaction_id']!, _linkedTransactionIdMeta));
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
          _linkedAccountIdMeta,
          linkedAccountId.isAcceptableOrUnknown(
              data['linked_account_id']!, _linkedAccountIdMeta));
    }
    if (data.containsKey('transfer_description')) {
      context.handle(
          _transferDescriptionMeta,
          transferDescription.isAcceptableOrUnknown(
              data['transfer_description']!, _transferDescriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      creatorUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator_uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}transaction_date'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      transactionType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_type'])!,
      transactionAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}transaction_amount'])!,
      baseAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}base_amount'])!,
      baseCurrency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}base_currency'])!,
      exchangeRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}exchange_rate']),
      targetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_amount']),
      targetCurrency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_currency']),
      linkedTransactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_transaction_id']),
      linkedAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_account_id']),
      transferDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transfer_description']),
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionDTO extends DataClass implements Insertable<TransactionDTO> {
  final String id;
  final String creatorUid;
  final String name;
  final String? description;
  final DateTime transactionDate;
  final String accountId;
  final String transactionType;
  final double transactionAmount;
  final double baseAmount;
  final String baseCurrency;
  final double? exchangeRate;
  final double? targetAmount;
  final String? targetCurrency;

  /// These fields are kept in [TransferDetails].
  final String? linkedTransactionId;
  final String? linkedAccountId;
  final String? transferDescription;
  const TransactionDTO(
      {required this.id,
      required this.creatorUid,
      required this.name,
      this.description,
      required this.transactionDate,
      required this.accountId,
      required this.transactionType,
      required this.transactionAmount,
      required this.baseAmount,
      required this.baseCurrency,
      this.exchangeRate,
      this.targetAmount,
      this.targetCurrency,
      this.linkedTransactionId,
      this.linkedAccountId,
      this.transferDescription});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['creator_uid'] = Variable<String>(creatorUid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    map['account_id'] = Variable<String>(accountId);
    map['transaction_type'] = Variable<String>(transactionType);
    map['transaction_amount'] = Variable<double>(transactionAmount);
    map['base_amount'] = Variable<double>(baseAmount);
    map['base_currency'] = Variable<String>(baseCurrency);
    if (!nullToAbsent || exchangeRate != null) {
      map['exchange_rate'] = Variable<double>(exchangeRate);
    }
    if (!nullToAbsent || targetAmount != null) {
      map['target_amount'] = Variable<double>(targetAmount);
    }
    if (!nullToAbsent || targetCurrency != null) {
      map['target_currency'] = Variable<String>(targetCurrency);
    }
    if (!nullToAbsent || linkedTransactionId != null) {
      map['linked_transaction_id'] = Variable<String>(linkedTransactionId);
    }
    if (!nullToAbsent || linkedAccountId != null) {
      map['linked_account_id'] = Variable<String>(linkedAccountId);
    }
    if (!nullToAbsent || transferDescription != null) {
      map['transfer_description'] = Variable<String>(transferDescription);
    }
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      creatorUid: Value(creatorUid),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      transactionDate: Value(transactionDate),
      accountId: Value(accountId),
      transactionType: Value(transactionType),
      transactionAmount: Value(transactionAmount),
      baseAmount: Value(baseAmount),
      baseCurrency: Value(baseCurrency),
      exchangeRate: exchangeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(exchangeRate),
      targetAmount: targetAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(targetAmount),
      targetCurrency: targetCurrency == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCurrency),
      linkedTransactionId: linkedTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedTransactionId),
      linkedAccountId: linkedAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAccountId),
      transferDescription: transferDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(transferDescription),
    );
  }

  factory TransactionDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDTO(
      id: serializer.fromJson<String>(json['id']),
      creatorUid: serializer.fromJson<String>(json['creatorUid']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      accountId: serializer.fromJson<String>(json['accountId']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      transactionAmount: serializer.fromJson<double>(json['transactionAmount']),
      baseAmount: serializer.fromJson<double>(json['baseAmount']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      exchangeRate: serializer.fromJson<double?>(json['exchangeRate']),
      targetAmount: serializer.fromJson<double?>(json['targetAmount']),
      targetCurrency: serializer.fromJson<String?>(json['targetCurrency']),
      linkedTransactionId:
          serializer.fromJson<String?>(json['linkedTransactionId']),
      linkedAccountId: serializer.fromJson<String?>(json['linkedAccountId']),
      transferDescription:
          serializer.fromJson<String?>(json['transferDescription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'creatorUid': serializer.toJson<String>(creatorUid),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'accountId': serializer.toJson<String>(accountId),
      'transactionType': serializer.toJson<String>(transactionType),
      'transactionAmount': serializer.toJson<double>(transactionAmount),
      'baseAmount': serializer.toJson<double>(baseAmount),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'exchangeRate': serializer.toJson<double?>(exchangeRate),
      'targetAmount': serializer.toJson<double?>(targetAmount),
      'targetCurrency': serializer.toJson<String?>(targetCurrency),
      'linkedTransactionId': serializer.toJson<String?>(linkedTransactionId),
      'linkedAccountId': serializer.toJson<String?>(linkedAccountId),
      'transferDescription': serializer.toJson<String?>(transferDescription),
    };
  }

  TransactionDTO copyWith(
          {String? id,
          String? creatorUid,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? transactionDate,
          String? accountId,
          String? transactionType,
          double? transactionAmount,
          double? baseAmount,
          String? baseCurrency,
          Value<double?> exchangeRate = const Value.absent(),
          Value<double?> targetAmount = const Value.absent(),
          Value<String?> targetCurrency = const Value.absent(),
          Value<String?> linkedTransactionId = const Value.absent(),
          Value<String?> linkedAccountId = const Value.absent(),
          Value<String?> transferDescription = const Value.absent()}) =>
      TransactionDTO(
        id: id ?? this.id,
        creatorUid: creatorUid ?? this.creatorUid,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        transactionDate: transactionDate ?? this.transactionDate,
        accountId: accountId ?? this.accountId,
        transactionType: transactionType ?? this.transactionType,
        transactionAmount: transactionAmount ?? this.transactionAmount,
        baseAmount: baseAmount ?? this.baseAmount,
        baseCurrency: baseCurrency ?? this.baseCurrency,
        exchangeRate:
            exchangeRate.present ? exchangeRate.value : this.exchangeRate,
        targetAmount:
            targetAmount.present ? targetAmount.value : this.targetAmount,
        targetCurrency:
            targetCurrency.present ? targetCurrency.value : this.targetCurrency,
        linkedTransactionId: linkedTransactionId.present
            ? linkedTransactionId.value
            : this.linkedTransactionId,
        linkedAccountId: linkedAccountId.present
            ? linkedAccountId.value
            : this.linkedAccountId,
        transferDescription: transferDescription.present
            ? transferDescription.value
            : this.transferDescription,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionDTO(')
          ..write('id: $id, ')
          ..write('creatorUid: $creatorUid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('accountId: $accountId, ')
          ..write('transactionType: $transactionType, ')
          ..write('transactionAmount: $transactionAmount, ')
          ..write('baseAmount: $baseAmount, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetCurrency: $targetCurrency, ')
          ..write('linkedTransactionId: $linkedTransactionId, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('transferDescription: $transferDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      creatorUid,
      name,
      description,
      transactionDate,
      accountId,
      transactionType,
      transactionAmount,
      baseAmount,
      baseCurrency,
      exchangeRate,
      targetAmount,
      targetCurrency,
      linkedTransactionId,
      linkedAccountId,
      transferDescription);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDTO &&
          other.id == this.id &&
          other.creatorUid == this.creatorUid &&
          other.name == this.name &&
          other.description == this.description &&
          other.transactionDate == this.transactionDate &&
          other.accountId == this.accountId &&
          other.transactionType == this.transactionType &&
          other.transactionAmount == this.transactionAmount &&
          other.baseAmount == this.baseAmount &&
          other.baseCurrency == this.baseCurrency &&
          other.exchangeRate == this.exchangeRate &&
          other.targetAmount == this.targetAmount &&
          other.targetCurrency == this.targetCurrency &&
          other.linkedTransactionId == this.linkedTransactionId &&
          other.linkedAccountId == this.linkedAccountId &&
          other.transferDescription == this.transferDescription);
}

class TransactionsTableCompanion extends UpdateCompanion<TransactionDTO> {
  final Value<String> id;
  final Value<String> creatorUid;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> transactionDate;
  final Value<String> accountId;
  final Value<String> transactionType;
  final Value<double> transactionAmount;
  final Value<double> baseAmount;
  final Value<String> baseCurrency;
  final Value<double?> exchangeRate;
  final Value<double?> targetAmount;
  final Value<String?> targetCurrency;
  final Value<String?> linkedTransactionId;
  final Value<String?> linkedAccountId;
  final Value<String?> transferDescription;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.creatorUid = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.transactionAmount = const Value.absent(),
    this.baseAmount = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.targetCurrency = const Value.absent(),
    this.linkedTransactionId = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.transferDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required String creatorUid,
    required String name,
    this.description = const Value.absent(),
    required DateTime transactionDate,
    required String accountId,
    required String transactionType,
    required double transactionAmount,
    required double baseAmount,
    required String baseCurrency,
    this.exchangeRate = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.targetCurrency = const Value.absent(),
    this.linkedTransactionId = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.transferDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        creatorUid = Value(creatorUid),
        name = Value(name),
        transactionDate = Value(transactionDate),
        accountId = Value(accountId),
        transactionType = Value(transactionType),
        transactionAmount = Value(transactionAmount),
        baseAmount = Value(baseAmount),
        baseCurrency = Value(baseCurrency);
  static Insertable<TransactionDTO> custom({
    Expression<String>? id,
    Expression<String>? creatorUid,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? transactionDate,
    Expression<String>? accountId,
    Expression<String>? transactionType,
    Expression<double>? transactionAmount,
    Expression<double>? baseAmount,
    Expression<String>? baseCurrency,
    Expression<double>? exchangeRate,
    Expression<double>? targetAmount,
    Expression<String>? targetCurrency,
    Expression<String>? linkedTransactionId,
    Expression<String>? linkedAccountId,
    Expression<String>? transferDescription,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creatorUid != null) 'creator_uid': creatorUid,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (accountId != null) 'account_id': accountId,
      if (transactionType != null) 'transaction_type': transactionType,
      if (transactionAmount != null) 'transaction_amount': transactionAmount,
      if (baseAmount != null) 'base_amount': baseAmount,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (targetCurrency != null) 'target_currency': targetCurrency,
      if (linkedTransactionId != null)
        'linked_transaction_id': linkedTransactionId,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (transferDescription != null)
        'transfer_description': transferDescription,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? creatorUid,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? transactionDate,
      Value<String>? accountId,
      Value<String>? transactionType,
      Value<double>? transactionAmount,
      Value<double>? baseAmount,
      Value<String>? baseCurrency,
      Value<double?>? exchangeRate,
      Value<double?>? targetAmount,
      Value<String?>? targetCurrency,
      Value<String?>? linkedTransactionId,
      Value<String?>? linkedAccountId,
      Value<String?>? transferDescription,
      Value<int>? rowid}) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      creatorUid: creatorUid ?? this.creatorUid,
      name: name ?? this.name,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      accountId: accountId ?? this.accountId,
      transactionType: transactionType ?? this.transactionType,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      baseAmount: baseAmount ?? this.baseAmount,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      targetAmount: targetAmount ?? this.targetAmount,
      targetCurrency: targetCurrency ?? this.targetCurrency,
      linkedTransactionId: linkedTransactionId ?? this.linkedTransactionId,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      transferDescription: transferDescription ?? this.transferDescription,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creatorUid.present) {
      map['creator_uid'] = Variable<String>(creatorUid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (transactionAmount.present) {
      map['transaction_amount'] = Variable<double>(transactionAmount.value);
    }
    if (baseAmount.present) {
      map['base_amount'] = Variable<double>(baseAmount.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (targetCurrency.present) {
      map['target_currency'] = Variable<String>(targetCurrency.value);
    }
    if (linkedTransactionId.present) {
      map['linked_transaction_id'] =
          Variable<String>(linkedTransactionId.value);
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<String>(linkedAccountId.value);
    }
    if (transferDescription.present) {
      map['transfer_description'] = Variable<String>(transferDescription.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('creatorUid: $creatorUid, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('accountId: $accountId, ')
          ..write('transactionType: $transactionType, ')
          ..write('transactionAmount: $transactionAmount, ')
          ..write('baseAmount: $baseAmount, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('targetCurrency: $targetCurrency, ')
          ..write('linkedTransactionId: $linkedTransactionId, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('transferDescription: $transferDescription, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoryDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _primaryColorMeta =
      const VerificationMeta('primaryColor');
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
      'primary_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumnWithTypeConverter<IconData?, String> icon =
      GeneratedColumn<String>('icon', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<IconData?>($CategoriesTableTable.$convertericonn);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, primaryColor, icon, parentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('primary_color')) {
      context.handle(
          _primaryColorMeta,
          primaryColor.isAcceptableOrUnknown(
              data['primary_color']!, _primaryColorMeta));
    } else if (isInserting) {
      context.missing(_primaryColorMeta);
    }
    context.handle(_iconMeta, const VerificationResult.success());
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      primaryColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_color'])!,
      icon: $CategoriesTableTable.$convertericonn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<IconData, String> $convertericon =
      const IconDataConverter();
  static TypeConverter<IconData?, String?> $convertericonn =
      NullAwareTypeConverter.wrap($convertericon);
}

class CategoryDTO extends DataClass implements Insertable<CategoryDTO> {
  final String id;
  final String name;
  final String? description;
  final String primaryColor;
  final IconData? icon;
  final String? parentId;
  const CategoryDTO(
      {required this.id,
      required this.name,
      this.description,
      required this.primaryColor,
      this.icon,
      this.parentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['primary_color'] = Variable<String>(primaryColor);
    if (!nullToAbsent || icon != null) {
      final converter = $CategoriesTableTable.$convertericonn;
      map['icon'] = Variable<String>(converter.toSql(icon));
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      primaryColor: Value(primaryColor),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
    );
  }

  factory CategoryDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryDTO(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      primaryColor: serializer.fromJson<String>(json['primaryColor']),
      icon: serializer.fromJson<IconData?>(json['icon']),
      parentId: serializer.fromJson<String?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'primaryColor': serializer.toJson<String>(primaryColor),
      'icon': serializer.toJson<IconData?>(icon),
      'parentId': serializer.toJson<String?>(parentId),
    };
  }

  CategoryDTO copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          String? primaryColor,
          Value<IconData?> icon = const Value.absent(),
          Value<String?> parentId = const Value.absent()}) =>
      CategoryDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        primaryColor: primaryColor ?? this.primaryColor,
        icon: icon.present ? icon.value : this.icon,
        parentId: parentId.present ? parentId.value : this.parentId,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryDTO(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('icon: $icon, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, primaryColor, icon, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryDTO &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.primaryColor == this.primaryColor &&
          other.icon == this.icon &&
          other.parentId == this.parentId);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoryDTO> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> primaryColor;
  final Value<IconData?> icon;
  final Value<String?> parentId;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.icon = const Value.absent(),
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String primaryColor,
    this.icon = const Value.absent(),
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        primaryColor = Value(primaryColor);
  static Insertable<CategoryDTO> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? primaryColor,
    Expression<String>? icon,
    Expression<String>? parentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (icon != null) 'icon': icon,
      if (parentId != null) 'parent_id': parentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String>? primaryColor,
      Value<IconData?>? icon,
      Value<String?>? parentId,
      Value<int>? rowid}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      primaryColor: primaryColor ?? this.primaryColor,
      icon: icon ?? this.icon,
      parentId: parentId ?? this.parentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (icon.present) {
      final converter = $CategoriesTableTable.$convertericonn;
      map['icon'] = Variable<String>(converter.toSql(icon.value));
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('icon: $icon, ')
          ..write('parentId: $parentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxnCategoriesTableTable extends TxnCategoriesTable
    with TableInfo<$TxnCategoriesTableTable, TransactionCategoryDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES transactions_table (id)'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [transactionId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txn_categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionCategoryDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transactionId, categoryId};
  @override
  TransactionCategoryDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionCategoryDTO(
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $TxnCategoriesTableTable createAlias(String alias) {
    return $TxnCategoriesTableTable(attachedDatabase, alias);
  }
}

class TransactionCategoryDTO extends DataClass
    implements Insertable<TransactionCategoryDTO> {
  final String transactionId;
  final String categoryId;
  const TransactionCategoryDTO(
      {required this.transactionId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transaction_id'] = Variable<String>(transactionId);
    map['category_id'] = Variable<String>(categoryId);
    return map;
  }

  TxnCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return TxnCategoriesTableCompanion(
      transactionId: Value(transactionId),
      categoryId: Value(categoryId),
    );
  }

  factory TransactionCategoryDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionCategoryDTO(
      transactionId: serializer.fromJson<String>(json['transactionId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionId': serializer.toJson<String>(transactionId),
      'categoryId': serializer.toJson<String>(categoryId),
    };
  }

  TransactionCategoryDTO copyWith(
          {String? transactionId, String? categoryId}) =>
      TransactionCategoryDTO(
        transactionId: transactionId ?? this.transactionId,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionCategoryDTO(')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(transactionId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionCategoryDTO &&
          other.transactionId == this.transactionId &&
          other.categoryId == this.categoryId);
}

class TxnCategoriesTableCompanion
    extends UpdateCompanion<TransactionCategoryDTO> {
  final Value<String> transactionId;
  final Value<String> categoryId;
  final Value<int> rowid;
  const TxnCategoriesTableCompanion({
    this.transactionId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TxnCategoriesTableCompanion.insert({
    required String transactionId,
    required String categoryId,
    this.rowid = const Value.absent(),
  })  : transactionId = Value(transactionId),
        categoryId = Value(categoryId);
  static Insertable<TransactionCategoryDTO> custom({
    Expression<String>? transactionId,
    Expression<String>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transactionId != null) 'transaction_id': transactionId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TxnCategoriesTableCompanion copyWith(
      {Value<String>? transactionId,
      Value<String>? categoryId,
      Value<int>? rowid}) {
    return TxnCategoriesTableCompanion(
      transactionId: transactionId ?? this.transactionId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnCategoriesTableCompanion(')
          ..write('transactionId: $transactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PecuniaDB extends GeneratedDatabase {
  _$PecuniaDB(QueryExecutor e) : super(e);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $TxnCategoriesTableTable txnCategoriesTable =
      $TxnCategoriesTableTable(this);
  late final AccountsLocalDAO accountsLocalDAO =
      AccountsLocalDAO(this as PecuniaDB);
  late final TransactionsLocalDAO transactionsLocalDAO =
      TransactionsLocalDAO(this as PecuniaDB);
  late final CategoriesLocalDAO categoriesLocalDAO =
      CategoriesLocalDAO(this as PecuniaDB);
  late final TxnCategoriesLocalDAO txnCategoriesLocalDAO =
      TxnCategoriesLocalDAO(this as PecuniaDB);
  late final DebugDAO debugDAO = DebugDAO(this as PecuniaDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [accountsTable, transactionsTable, categoriesTable, txnCategoriesTable];
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pecuniaDBHash() => r'12ac2257a15a1170557c84b0a17e9fec85a5182e';

/// See also [pecuniaDB].
@ProviderFor(pecuniaDB)
final pecuniaDBProvider = Provider<PecuniaDB>.internal(
  pecuniaDB,
  name: r'pecuniaDBProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pecuniaDBHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PecuniaDBRef = ProviderRef<PecuniaDB>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
