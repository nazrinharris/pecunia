// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_dao.dart';

// ignore_for_file: type=lint
mixin _$DebugDAOMixin on DatabaseAccessor<PecuniaDriftDB> {
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

String _$debugDAOHash() => r'411eef45c70cfaafc53f9e232d9c1f556c2b9fc1';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DebugDAORef = AutoDisposeProviderRef<DebugDAO>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
