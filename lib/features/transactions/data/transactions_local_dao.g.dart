// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_local_dao.dart';

// ignore_for_file: type=lint
mixin _$TransactionsLocalDAOMixin on DatabaseAccessor<PecuniaDB> {
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

String _$transactionsLocalDAOHash() =>
    r'0ff24cc35e7a0031a089e438811dbe17f421879d';

/// See also [transactionsLocalDAO].
@ProviderFor(transactionsLocalDAO)
final transactionsLocalDAOProvider =
    AutoDisposeProvider<TransactionsLocalDAO>.internal(
  transactionsLocalDAO,
  name: r'transactionsLocalDAOProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionsLocalDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionsLocalDAORef = AutoDisposeProviderRef<TransactionsLocalDAO>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
