// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_dao.dart';

// ignore_for_file: type=lint
mixin _$DebugDAOMixin on DatabaseAccessor<PecuniaDB> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  $TxnCategoriesTableTable get txnCategoriesTable =>
      attachedDatabase.txnCategoriesTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$debugDAOHash() => r'2e4d17fa3aed614eac9e040e40786069d5f42f71';

/// See also [debugDAO].
@ProviderFor(debugDAO)
final debugDAOProvider = AutoDisposeProvider<DebugDAO>.internal(
  debugDAO,
  name: r'debugDAOProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$debugDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DebugDAORef = AutoDisposeProviderRef<DebugDAO>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
