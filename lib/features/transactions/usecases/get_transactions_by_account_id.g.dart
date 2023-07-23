// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transactions_by_account_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTransactionsByAccountIdHash() =>
    r'f3f650a22496992223b7e94cea358d5e9d711c74';

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

typedef GetTransactionsByAccountIdRef
    = AutoDisposeFutureProviderRef<List<Transaction>>;

/// See also [getTransactionsByAccountId].
@ProviderFor(getTransactionsByAccountId)
const getTransactionsByAccountIdProvider = GetTransactionsByAccountIdFamily();

/// See also [getTransactionsByAccountId].
class GetTransactionsByAccountIdFamily
    extends Family<AsyncValue<List<Transaction>>> {
  /// See also [getTransactionsByAccountId].
  const GetTransactionsByAccountIdFamily();

  /// See also [getTransactionsByAccountId].
  GetTransactionsByAccountIdProvider call(
    String accountId,
  ) {
    return GetTransactionsByAccountIdProvider(
      accountId,
    );
  }

  @override
  GetTransactionsByAccountIdProvider getProviderOverride(
    covariant GetTransactionsByAccountIdProvider provider,
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
  String? get name => r'getTransactionsByAccountIdProvider';
}

/// See also [getTransactionsByAccountId].
class GetTransactionsByAccountIdProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [getTransactionsByAccountId].
  GetTransactionsByAccountIdProvider(
    this.accountId,
  ) : super.internal(
          (ref) => getTransactionsByAccountId(
            ref,
            accountId,
          ),
          from: getTransactionsByAccountIdProvider,
          name: r'getTransactionsByAccountIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTransactionsByAccountIdHash,
          dependencies: GetTransactionsByAccountIdFamily._dependencies,
          allTransitiveDependencies:
              GetTransactionsByAccountIdFamily._allTransitiveDependencies,
        );

  final String accountId;

  @override
  bool operator ==(Object other) {
    return other is GetTransactionsByAccountIdProvider &&
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
