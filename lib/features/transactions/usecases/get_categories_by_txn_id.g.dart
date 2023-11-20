// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_by_txn_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCategoriesByTxnIdHash() =>
    r'fa3e6e1767ea2c26a0edaa7f1dc58e898a657205';

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

/// See also [getCategoriesByTxnId].
@ProviderFor(getCategoriesByTxnId)
const getCategoriesByTxnIdProvider = GetCategoriesByTxnIdFamily();

/// See also [getCategoriesByTxnId].
class GetCategoriesByTxnIdFamily extends Family<AsyncValue<List<Category>>> {
  /// See also [getCategoriesByTxnId].
  const GetCategoriesByTxnIdFamily();

  /// See also [getCategoriesByTxnId].
  GetCategoriesByTxnIdProvider call(
    String txnId, {
    bool? debugReturnError,
  }) {
    return GetCategoriesByTxnIdProvider(
      txnId,
      debugReturnError: debugReturnError,
    );
  }

  @override
  GetCategoriesByTxnIdProvider getProviderOverride(
    covariant GetCategoriesByTxnIdProvider provider,
  ) {
    return call(
      provider.txnId,
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
  String? get name => r'getCategoriesByTxnIdProvider';
}

/// See also [getCategoriesByTxnId].
class GetCategoriesByTxnIdProvider
    extends AutoDisposeFutureProvider<List<Category>> {
  /// See also [getCategoriesByTxnId].
  GetCategoriesByTxnIdProvider(
    String txnId, {
    bool? debugReturnError,
  }) : this._internal(
          (ref) => getCategoriesByTxnId(
            ref as GetCategoriesByTxnIdRef,
            txnId,
            debugReturnError: debugReturnError,
          ),
          from: getCategoriesByTxnIdProvider,
          name: r'getCategoriesByTxnIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCategoriesByTxnIdHash,
          dependencies: GetCategoriesByTxnIdFamily._dependencies,
          allTransitiveDependencies:
              GetCategoriesByTxnIdFamily._allTransitiveDependencies,
          txnId: txnId,
          debugReturnError: debugReturnError,
        );

  GetCategoriesByTxnIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.txnId,
    required this.debugReturnError,
  }) : super.internal();

  final String txnId;
  final bool? debugReturnError;

  @override
  Override overrideWith(
    FutureOr<List<Category>> Function(GetCategoriesByTxnIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCategoriesByTxnIdProvider._internal(
        (ref) => create(ref as GetCategoriesByTxnIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        txnId: txnId,
        debugReturnError: debugReturnError,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Category>> createElement() {
    return _GetCategoriesByTxnIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCategoriesByTxnIdProvider &&
        other.txnId == txnId &&
        other.debugReturnError == debugReturnError;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, txnId.hashCode);
    hash = _SystemHash.combine(hash, debugReturnError.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCategoriesByTxnIdRef on AutoDisposeFutureProviderRef<List<Category>> {
  /// The parameter `txnId` of this provider.
  String get txnId;

  /// The parameter `debugReturnError` of this provider.
  bool? get debugReturnError;
}

class _GetCategoriesByTxnIdProviderElement
    extends AutoDisposeFutureProviderElement<List<Category>>
    with GetCategoriesByTxnIdRef {
  _GetCategoriesByTxnIdProviderElement(super.provider);

  @override
  String get txnId => (origin as GetCategoriesByTxnIdProvider).txnId;
  @override
  bool? get debugReturnError =>
      (origin as GetCategoriesByTxnIdProvider).debugReturnError;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
