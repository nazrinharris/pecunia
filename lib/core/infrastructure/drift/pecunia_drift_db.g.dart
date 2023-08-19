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
  String get aliasedName => _alias ?? 'accounts_table';
  @override
  String get actualTableName => 'accounts_table';
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
  String get aliasedName => _alias ?? 'transactions_table';
  @override
  String get actualTableName => 'transactions_table';
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

abstract class _$PecuniaDB extends GeneratedDatabase {
  _$PecuniaDB(QueryExecutor e) : super(e);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final AccountsLocalDAO accountsLocalDAO =
      AccountsLocalDAO(this as PecuniaDB);
  late final TransactionsDAO transactionsDAO =
      TransactionsDAO(this as PecuniaDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [accountsTable, transactionsTable];
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
