// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountByIdHash() => r'0a93fc02dbd20830f783f71b4eec23bdd2563d8b';

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

/// See also [getAccountById].
@ProviderFor(getAccountById)
const getAccountByIdProvider = GetAccountByIdFamily();

/// See also [getAccountById].
class GetAccountByIdFamily extends Family<AsyncValue<Account>> {
  /// See also [getAccountById].
  const GetAccountByIdFamily();

  /// See also [getAccountById].
  GetAccountByIdProvider call(
    String accountId, {
    bool? debugReturnError,
  }) {
    return GetAccountByIdProvider(
      accountId,
      debugReturnError: debugReturnError,
    );
  }

  @override
  GetAccountByIdProvider getProviderOverride(
    covariant GetAccountByIdProvider provider,
  ) {
    return call(
      provider.accountId,
      debugReturnError: provider.debugReturnError,
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
  String? get name => r'getAccountByIdProvider';
}

/// See also [getAccountById].
class GetAccountByIdProvider extends AutoDisposeFutureProvider<Account> {
  /// See also [getAccountById].
  GetAccountByIdProvider(
    String accountId, {
    bool? debugReturnError,
  }) : this._internal(
          (ref) => getAccountById(
            ref as GetAccountByIdRef,
            accountId,
            debugReturnError: debugReturnError,
          ),
          from: getAccountByIdProvider,
          name: r'getAccountByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAccountByIdHash,
          dependencies: GetAccountByIdFamily._dependencies,
          allTransitiveDependencies:
              GetAccountByIdFamily._allTransitiveDependencies,
          accountId: accountId,
          debugReturnError: debugReturnError,
        );

  GetAccountByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
    required this.debugReturnError,
  }) : super.internal();

  final String accountId;
  final bool? debugReturnError;

  @override
  Override overrideWith(
    FutureOr<Account> Function(GetAccountByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAccountByIdProvider._internal(
        (ref) => create(ref as GetAccountByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountId: accountId,
        debugReturnError: debugReturnError,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Account> createElement() {
    return _GetAccountByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAccountByIdProvider &&
        other.accountId == accountId &&
        other.debugReturnError == debugReturnError;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);
    hash = _SystemHash.combine(hash, debugReturnError.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetAccountByIdRef on AutoDisposeFutureProviderRef<Account> {
  /// The parameter `accountId` of this provider.
  String get accountId;

  /// The parameter `debugReturnError` of this provider.
  bool? get debugReturnError;
}

class _GetAccountByIdProviderElement
    extends AutoDisposeFutureProviderElement<Account> with GetAccountByIdRef {
  _GetAccountByIdProviderElement(super.provider);

  @override
  String get accountId => (origin as GetAccountByIdProvider).accountId;
  @override
  bool? get debugReturnError =>
      (origin as GetAccountByIdProvider).debugReturnError;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
