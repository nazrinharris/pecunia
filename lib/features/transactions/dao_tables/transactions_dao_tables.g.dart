// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_dao_tables.dart';

// ignore_for_file: type=lint
mixin _$TransactionsDAOMixin on DatabaseAccessor<PecuniaDB> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionsDAOHash() => r'6ed5ae233891eac2b670eaec07cffcfaf89c1b70';

/// See also [transactionsDAO].
@ProviderFor(transactionsDAO)
final transactionsDAOProvider = AutoDisposeProvider<TransactionsDAO>.internal(
  transactionsDAO,
  name: r'transactionsDAOProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionsDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionsDAORef = AutoDisposeProviderRef<TransactionsDAO>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
