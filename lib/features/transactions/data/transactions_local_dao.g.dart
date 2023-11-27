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
    r'd385309a589e78aaf5e9dcf91d58848880025698';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
