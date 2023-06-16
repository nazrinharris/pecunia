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

abstract class _$PecuniaDB extends GeneratedDatabase {
  _$PecuniaDB(QueryExecutor e) : super(e);
  late final $DebugTableTable debugTable = $DebugTableTable(this);
  late final DebugDAO debugDAO = DebugDAO(this as PecuniaDB);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [debugTable];
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
