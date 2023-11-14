// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_id_and_all_accounts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountByIdAndAllAccountsHash() =>
    r'230982f998d581cf5a3e9786f8c37a9b81a82ccc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetAccountByIdAndAllAccountsRef = AutoDisposeFutureProviderRef<
    ({Account account, List<Account> accountsList})>;

/// See also [getAccountByIdAndAllAccounts].
@ProviderFor(getAccountByIdAndAllAccounts)
const getAccountByIdAndAllAccountsProvider =
    GetAccountByIdAndAllAccountsFamily();

/// See also [getAccountByIdAndAllAccounts].
class GetAccountByIdAndAllAccountsFamily extends Family<
    AsyncValue<({Account account, List<Account> accountsList})>> {
  /// See also [getAccountByIdAndAllAccounts].
  const GetAccountByIdAndAllAccountsFamily();

  /// See also [getAccountByIdAndAllAccounts].
  GetAccountByIdAndAllAccountsProvider call(
    String accountId,
  ) {
    return GetAccountByIdAndAllAccountsProvider(
      accountId,
    );
  }

  @override
  GetAccountByIdAndAllAccountsProvider getProviderOverride(
    covariant GetAccountByIdAndAllAccountsProvider provider,
  ) {
    return call(
      provider.accountId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getAccountByIdAndAllAccountsProvider';
}

/// See also [getAccountByIdAndAllAccounts].
class GetAccountByIdAndAllAccountsProvider extends AutoDisposeFutureProvider<
    ({Account account, List<Account> accountsList})> {
  /// See also [getAccountByIdAndAllAccounts].
  GetAccountByIdAndAllAccountsProvider(
    this.accountId,
  ) : super.internal(
          (ref) => getAccountByIdAndAllAccounts(
            ref,
            accountId,
          ),
          from: getAccountByIdAndAllAccountsProvider,
          name: r'getAccountByIdAndAllAccountsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAccountByIdAndAllAccountsHash,
          dependencies: GetAccountByIdAndAllAccountsFamily._dependencies,
          allTransitiveDependencies:
              GetAccountByIdAndAllAccountsFamily._allTransitiveDependencies,
        );

  final String accountId;

  @override
  bool operator ==(Object other) {
    return other is GetAccountByIdAndAllAccountsProvider &&
        other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
