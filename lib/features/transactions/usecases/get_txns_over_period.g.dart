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

typedef GetTxnsOverPeriodRef = AutoDisposeFutureProviderRef<List<Transaction>>;

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
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.currency,
    this.includeTransfers = false,
  }) : super.internal(
          (ref) => getTxnsOverPeriod(
            ref,
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
        );

  final DateTime startDate;
  final DateTime endDate;
  final TransactionType type;
  final Currency currency;
  final bool includeTransfers;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
