// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_local_db_provider.dart';

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
String _$createAccountHash() => r'61f6641cbec116ec343334c3962a2282d0878d4f';

/// See also [CreateAccount].
@ProviderFor(CreateAccount)
final createAccountProvider =
    AutoDisposeAsyncNotifierProvider<CreateAccount, Option<Unit>>.internal(
  CreateAccount.new,
  name: r'createAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateAccount = AutoDisposeAsyncNotifier<Option<Unit>>;
String _$deleteAccountHash() => r'05500b1e0c5c2f362d1d38c08d7e403179be3f6c';

/// See also [DeleteAccount].
@ProviderFor(DeleteAccount)
final deleteAccountProvider =
    AutoDisposeAsyncNotifierProvider<DeleteAccount, Option<Unit>>.internal(
  DeleteAccount.new,
  name: r'deleteAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteAccount = AutoDisposeAsyncNotifier<Option<Unit>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
