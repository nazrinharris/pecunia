// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_by_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTransactionByIdHash() =>
    r'f08f20e71a077413f87d248ed063264901ea931d';

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

typedef GetTransactionByIdRef = AutoDisposeFutureProviderRef<Transaction>;

/// See also [getTransactionById].
@ProviderFor(getTransactionById)
const getTransactionByIdProvider = GetTransactionByIdFamily();

/// See also [getTransactionById].
class GetTransactionByIdFamily extends Family<AsyncValue<Transaction>> {
  /// See also [getTransactionById].
  const GetTransactionByIdFamily();

  /// See also [getTransactionById].
  GetTransactionByIdProvider call(
    String txnId, {
    bool? debugReturnError,
  }) {
    return GetTransactionByIdProvider(
      txnId,
      debugReturnError: debugReturnError,
    );
  }

  @override
  GetTransactionByIdProvider getProviderOverride(
    covariant GetTransactionByIdProvider provider,
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
  String? get name => r'getTransactionByIdProvider';
}

/// See also [getTransactionById].
class GetTransactionByIdProvider
    extends AutoDisposeFutureProvider<Transaction> {
  /// See also [getTransactionById].
  GetTransactionByIdProvider(
    this.txnId, {
    this.debugReturnError,
  }) : super.internal(
          (ref) => getTransactionById(
            ref,
            txnId,
            debugReturnError: debugReturnError,
          ),
          from: getTransactionByIdProvider,
          name: r'getTransactionByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTransactionByIdHash,
          dependencies: GetTransactionByIdFamily._dependencies,
          allTransitiveDependencies:
              GetTransactionByIdFamily._allTransitiveDependencies,
        );

  final String txnId;
  final bool? debugReturnError;

  @override
  bool operator ==(Object other) {
    return other is GetTransactionByIdProvider &&
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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
