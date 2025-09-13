// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_txns_over_period.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTxnsOverPeriodHash() => r'704a79da56636ffd8f92a6758507a1116d1fc04b';

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

/// See also [getTxnsOverPeriod].
@ProviderFor(getTxnsOverPeriod)
const getTxnsOverPeriodProvider = GetTxnsOverPeriodFamily();

/// See also [getTxnsOverPeriod].
class GetTxnsOverPeriodFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [getTxnsOverPeriod].
  const GetTxnsOverPeriodFamily();

  /// See also [getTxnsOverPeriod].
  GetTxnsOverPeriodProvider call({
    required DateTime startDate,
    required DateTime endDate,
    required TransactionType type,
    required Currency currency,
    bool includeTransfers = false,
  }) {
    return GetTxnsOverPeriodProvider(
      startDate: startDate,
      endDate: endDate,
      type: type,
      currency: currency,
      includeTransfers: includeTransfers,
    );
  }

  @override
  GetTxnsOverPeriodProvider getProviderOverride(
    covariant GetTxnsOverPeriodProvider provider,
  ) {
    return call(
      startDate: provider.startDate,
      endDate: provider.endDate,
      type: provider.type,
      currency: provider.currency,
      includeTransfers: provider.includeTransfers,
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
  String? get name => r'getTxnsOverPeriodProvider';
}

/// See also [getTxnsOverPeriod].
class GetTxnsOverPeriodProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [getTxnsOverPeriod].
  GetTxnsOverPeriodProvider({
    required DateTime startDate,
    required DateTime endDate,
    required TransactionType type,
    required Currency currency,
    bool includeTransfers = false,
  }) : this._internal(
          (ref) => getTxnsOverPeriod(
            ref as GetTxnsOverPeriodRef,
            startDate: startDate,
            endDate: endDate,
            type: type,
            currency: currency,
            includeTransfers: includeTransfers,
          ),
          from: getTxnsOverPeriodProvider,
          name: r'getTxnsOverPeriodProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTxnsOverPeriodHash,
          dependencies: GetTxnsOverPeriodFamily._dependencies,
          allTransitiveDependencies:
              GetTxnsOverPeriodFamily._allTransitiveDependencies,
          startDate: startDate,
          endDate: endDate,
          type: type,
          currency: currency,
          includeTransfers: includeTransfers,
        );

  GetTxnsOverPeriodProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.currency,
    required this.includeTransfers,
  }) : super.internal();

  final DateTime startDate;
  final DateTime endDate;
  final TransactionType type;
  final Currency currency;
  final bool includeTransfers;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>> Function(GetTxnsOverPeriodRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTxnsOverPeriodProvider._internal(
        (ref) => create(ref as GetTxnsOverPeriodRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        startDate: startDate,
        endDate: endDate,
        type: type,
        currency: currency,
        includeTransfers: includeTransfers,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>> createElement() {
    return _GetTxnsOverPeriodProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTxnsOverPeriodProvider &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.type == type &&
        other.currency == currency &&
        other.includeTransfers == includeTransfers;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);
    hash = _SystemHash.combine(hash, includeTransfers.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTxnsOverPeriodRef on AutoDisposeFutureProviderRef<List<Transaction>> {
  /// The parameter `startDate` of this provider.
  DateTime get startDate;

  /// The parameter `endDate` of this provider.
  DateTime get endDate;

  /// The parameter `type` of this provider.
  TransactionType get type;

  /// The parameter `currency` of this provider.
  Currency get currency;

  /// The parameter `includeTransfers` of this provider.
  bool get includeTransfers;
}

class _GetTxnsOverPeriodProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>>
    with GetTxnsOverPeriodRef {
  _GetTxnsOverPeriodProviderElement(super.provider);

  @override
  DateTime get startDate => (origin as GetTxnsOverPeriodProvider).startDate;
  @override
  DateTime get endDate => (origin as GetTxnsOverPeriodProvider).endDate;
  @override
  TransactionType get type => (origin as GetTxnsOverPeriodProvider).type;
  @override
  Currency get currency => (origin as GetTxnsOverPeriodProvider).currency;
  @override
  bool get includeTransfers =>
      (origin as GetTxnsOverPeriodProvider).includeTransfers;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
