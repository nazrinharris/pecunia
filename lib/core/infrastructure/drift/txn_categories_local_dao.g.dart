// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txn_categories_local_dao.dart';

// ignore_for_file: type=lint
mixin _$TxnCategoriesLocalDAOMixin on DatabaseAccessor<PecuniaDB> {
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
    r'13d298ed01727a2a78d482a48240ead5f2284a32';

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

typedef TxnCategoriesLocalDAORef
    = AutoDisposeProviderRef<TxnCategoriesLocalDAO>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
