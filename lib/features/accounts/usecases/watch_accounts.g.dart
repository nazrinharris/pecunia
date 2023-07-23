// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_accounts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchAccountsHash() => r'5d3a05c7c3f659f554edcb3e40ff28b450b1b18b';

/// See also [watchAccounts].
@ProviderFor(watchAccounts)
final watchAccountsProvider =
    AutoDisposeStreamProvider<Either<AccountsFailure, List<Account>>>.internal(
  watchAccounts,
  name: r'watchAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAccountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAccountsRef
    = AutoDisposeStreamProviderRef<Either<AccountsFailure, List<Account>>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
