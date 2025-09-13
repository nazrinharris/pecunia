// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_txns_current_month.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTxnsCurrentMonthHash() =>
    r'6ea469dc4dede628927232ea39062ff3be6a4205';

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

/// See also [getTxnsCurrentMonth].
@ProviderFor(getTxnsCurrentMonth)
const getTxnsCurrentMonthProvider = GetTxnsCurrentMonthFamily();

/// See also [getTxnsCurrentMonth].
class GetTxnsCurrentMonthFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [getTxnsCurrentMonth].
  const GetTxnsCurrentMonthFamily();

  /// See also [getTxnsCurrentMonth].
  GetTxnsCurrentMonthProvider call({
    required TransactionType type,
    required Currency currency,
  }) {
    return GetTxnsCurrentMonthProvider(
      type: type,
      currency: currency,
    );
  }

  @override
  GetTxnsCurrentMonthProvider getProviderOverride(
    covariant GetTxnsCurrentMonthProvider provider,
  ) {
    return call(
      type: provider.type,
      currency: provider.currency,
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
  String? get name => r'getTxnsCurrentMonthProvider';
}

/// See also [getTxnsCurrentMonth].
class GetTxnsCurrentMonthProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [getTxnsCurrentMonth].
  GetTxnsCurrentMonthProvider({
    required TransactionType type,
    required Currency currency,
  }) : this._internal(
          (ref) => getTxnsCurrentMonth(
            ref as GetTxnsCurrentMonthRef,
            type: type,
            currency: currency,
          ),
          from: getTxnsCurrentMonthProvider,
          name: r'getTxnsCurrentMonthProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTxnsCurrentMonthHash,
          dependencies: GetTxnsCurrentMonthFamily._dependencies,
          allTransitiveDependencies:
              GetTxnsCurrentMonthFamily._allTransitiveDependencies,
          type: type,
          currency: currency,
        );

  GetTxnsCurrentMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.currency,
  }) : super.internal();

  final TransactionType type;
  final Currency currency;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>> Function(GetTxnsCurrentMonthRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTxnsCurrentMonthProvider._internal(
        (ref) => create(ref as GetTxnsCurrentMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        currency: currency,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>> createElement() {
    return _GetTxnsCurrentMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTxnsCurrentMonthProvider &&
        other.type == type &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTxnsCurrentMonthRef
    on AutoDisposeFutureProviderRef<List<Transaction>> {
  /// The parameter `type` of this provider.
  TransactionType get type;

  /// The parameter `currency` of this provider.
  Currency get currency;
}

class _GetTxnsCurrentMonthProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>>
    with GetTxnsCurrentMonthRef {
  _GetTxnsCurrentMonthProviderElement(super.provider);

  @override
  TransactionType get type => (origin as GetTxnsCurrentMonthProvider).type;
  @override
  Currency get currency => (origin as GetTxnsCurrentMonthProvider).currency;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
