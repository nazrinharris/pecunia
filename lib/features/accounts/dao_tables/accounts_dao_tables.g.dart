// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_dao_tables.dart';

// ignore_for_file: type=lint
mixin _$AccountsDAOMixin on DatabaseAccessor<PecuniaDB> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsDAOHash() => r'd2fa1a9a3332fe4d9a76fec60efd6728e642be72';

/// See also [accountsDAO].
@ProviderFor(accountsDAO)
final accountsDAOProvider = AutoDisposeProvider<AccountsDAO>.internal(
  accountsDAO,
  name: r'accountsDAOProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountsDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountsDAORef = AutoDisposeProviderRef<AccountsDAO>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
