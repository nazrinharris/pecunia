// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_local_dao.dart';

// ignore_for_file: type=lint
mixin _$AccountsLocalDAOMixin on DatabaseAccessor<PecuniaDB> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsLocalDAOHash() => r'd345b468835a386d6dc8a8eb3d9cda52a2d92113';

/// See also [accountsLocalDAO].
@ProviderFor(accountsLocalDAO)
final accountsLocalDAOProvider = AutoDisposeProvider<AccountsLocalDAO>.internal(
  accountsLocalDAO,
  name: r'accountsLocalDAOProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountsLocalDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountsLocalDAORef = AutoDisposeProviderRef<AccountsLocalDAO>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
