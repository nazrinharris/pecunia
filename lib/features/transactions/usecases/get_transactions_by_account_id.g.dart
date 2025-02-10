// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transactions_by_account_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTransactionsByAccountIdHash() =>
    r'6c1df614210740540ef13b27f2321c628aa3e761';

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
    String accountId,
  ) : this._internal(
          (ref) => getTransactionsByAccountId(
            ref as GetTransactionsByAccountIdRef,
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
          accountId: accountId,
        );

  GetTransactionsByAccountIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
  }) : super.internal();

  final String accountId;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>> Function(GetTransactionsByAccountIdRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTransactionsByAccountIdProvider._internal(
        (ref) => create(ref as GetTransactionsByAccountIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountId: accountId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>> createElement() {
    return _GetTransactionsByAccountIdProviderElement(this);
  }

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTransactionsByAccountIdRef
    on AutoDisposeFutureProviderRef<List<Transaction>> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _GetTransactionsByAccountIdProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>>
    with GetTransactionsByAccountIdRef {
  _GetTransactionsByAccountIdProviderElement(super.provider);

  @override
  String get accountId =>
      (origin as GetTransactionsByAccountIdProvider).accountId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
