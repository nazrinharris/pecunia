// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txn_categories_local_dao.dart';

// ignore_for_file: type=lint
mixin _$TxnCategoriesLocalDAOMixin on DatabaseAccessor<PecuniaDriftDB> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
  $TxnCategoriesTableTable get txnCategoriesTable =>
      attachedDatabase.txnCategoriesTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$txnCategoriesLocalDAOHash() =>
    r'f657bcf48248d029b17357cab9d9562abef14816';

/// See also [txnCategoriesLocalDAO].
@ProviderFor(txnCategoriesLocalDAO)
final txnCategoriesLocalDAOProvider =
    AutoDisposeProvider<TxnCategoriesLocalDAO>.internal(
  txnCategoriesLocalDAO,
  name: r'txnCategoriesLocalDAOProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$txnCategoriesLocalDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TxnCategoriesLocalDAORef
    = AutoDisposeProviderRef<TxnCategoriesLocalDAO>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
