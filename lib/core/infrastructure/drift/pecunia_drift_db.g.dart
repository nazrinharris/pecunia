// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pecunia_drift_db.dart';

// ignore_for_file: type=lint
class $DebugTableTable extends DebugTable
    with TableInfo<$DebugTableTable, DebugEntryDTO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebugTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String> desc = GeneratedColumn<String>(
      'desc', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, desc];
  @override
  String get aliasedName => _alias ?? 'debug_table';
  @override
  String get actualTableName => 'debug_table';
  @override
  VerificationContext validateIntegrity(Insertable<DebugEntryDTO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebugEntryDTO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebugEntryDTO(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      desc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}desc'])!,
    );
  }

  @override
  $DebugTableTable createAlias(String alias) {
    return $DebugTableTable(attachedDatabase, alias);
  }
}

class DebugEntryDTO extends DataClass implements Insertable<DebugEntryDTO> {
  final int id;
  final String desc;
  const DebugEntryDTO({required this.id, required this.desc});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['desc'] = Variable<String>(desc);
    return map;
  }

  DebugTableCompanion toCompanion(bool nullToAbsent) {
    return DebugTableCompanion(
      id: Value(id),
      desc: Value(desc),
    );
  }

  factory DebugEntryDTO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebugEntryDTO(
      id: serializer.fromJson<int>(json['id']),
      desc: serializer.fromJson<String>(json['desc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'desc': serializer.toJson<String>(desc),
    };
  }

  DebugEntryDTO copyWith({int? id, String? desc}) => DebugEntryDTO(
        id: id ?? this.id,
        desc: desc ?? this.desc,
      );
  @override
  String toString() {
    return (StringBuffer('DebugEntryDTO(')
          ..write('id: $id, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, desc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebugEntryDTO &&
          other.id == this.id &&
          other.desc == this.desc);
}

class DebugTableCompanion extends UpdateCompanion<DebugEntryDTO> {
  final Value<int> id;
  final Value<String> desc;
  const DebugTableCompanion({
    this.id = const Value.absent(),
    this.desc = const Value.absent(),
  });
  DebugTableCompanion.insert({
    this.id = const Value.absent(),
    required String desc,
  }) : desc = Value(desc);
  static Insertable<DebugEntryDTO> custom({
    Expression<int>? id,
    Expression<String>? desc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (desc != null) 'desc': desc,
    });
  }

  DebugTableCompanion copyWith({Value<int>? id, Value<String>? desc}) {
    return DebugTableCompanion(
      id: id ?? this.id,
      desc: desc ?? this.desc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebugTableCompanion(')
          ..write('id: $id, ')
          ..write('desc: $desc')
          ..write(')'))
        .toString();
  }
}

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

abstract class _$PecuniaDB extends GeneratedDatabase {
  _$PecuniaDB(QueryExecutor e) : super(e);
  late final $DebugTableTable debugTable = $DebugTableTable(this);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final DebugDAO debugDAO = DebugDAO(this as PecuniaDB);
  late final AccountsDAO accountsDAO = AccountsDAO(this as PecuniaDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [debugTable, accountsTable];
}

mixin _$DebugDAOMixin on DatabaseAccessor<PecuniaDB> {
  $DebugTableTable get debugTable => attachedDatabase.debugTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pecuniaDBHash() => r'3c8a377a761d7367cbf8c42149cc7d63596e98e5';

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
