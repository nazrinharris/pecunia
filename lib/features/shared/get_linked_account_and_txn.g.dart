// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_linked_account_and_txn.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLinkedAccountAndTxnHash() =>
    r'234b68aeab8d3b0c2d41f451a7dedfc090704142';

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

typedef GetLinkedAccountAndTxnRef
    = AutoDisposeFutureProviderRef<(Account, Transaction)>;

/// See also [getLinkedAccountAndTxn].
@ProviderFor(getLinkedAccountAndTxn)
const getLinkedAccountAndTxnProvider = GetLinkedAccountAndTxnFamily();

/// See also [getLinkedAccountAndTxn].
class GetLinkedAccountAndTxnFamily
    extends Family<AsyncValue<(Account, Transaction)>> {
  /// See also [getLinkedAccountAndTxn].
  const GetLinkedAccountAndTxnFamily();

  /// See also [getLinkedAccountAndTxn].
  GetLinkedAccountAndTxnProvider call({
    required String accountId,
    required String txnId,
    bool? debugReturnErrorAccount,
    bool? debugReturnErrorTransaction,
  }) {
    return GetLinkedAccountAndTxnProvider(
      accountId: accountId,
      txnId: txnId,
      debugReturnErrorAccount: debugReturnErrorAccount,
      debugReturnErrorTransaction: debugReturnErrorTransaction,
    );
  }

  @override
  GetLinkedAccountAndTxnProvider getProviderOverride(
    covariant GetLinkedAccountAndTxnProvider provider,
  ) {
    return call(
      accountId: provider.accountId,
      txnId: provider.txnId,
      debugReturnErrorAccount: provider.debugReturnErrorAccount,
      debugReturnErrorTransaction: provider.debugReturnErrorTransaction,
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
  String? get name => r'getLinkedAccountAndTxnProvider';
}

/// See also [getLinkedAccountAndTxn].
class GetLinkedAccountAndTxnProvider
    extends AutoDisposeFutureProvider<(Account, Transaction)> {
  /// See also [getLinkedAccountAndTxn].
  GetLinkedAccountAndTxnProvider({
    required this.accountId,
    required this.txnId,
    this.debugReturnErrorAccount,
    this.debugReturnErrorTransaction,
  }) : super.internal(
          (ref) => getLinkedAccountAndTxn(
            ref,
            accountId: accountId,
            txnId: txnId,
            debugReturnErrorAccount: debugReturnErrorAccount,
            debugReturnErrorTransaction: debugReturnErrorTransaction,
          ),
          from: getLinkedAccountAndTxnProvider,
          name: r'getLinkedAccountAndTxnProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLinkedAccountAndTxnHash,
          dependencies: GetLinkedAccountAndTxnFamily._dependencies,
          allTransitiveDependencies:
              GetLinkedAccountAndTxnFamily._allTransitiveDependencies,
        );

  final String accountId;
  final String txnId;
  final bool? debugReturnErrorAccount;
  final bool? debugReturnErrorTransaction;

  @override
  bool operator ==(Object other) {
    return other is GetLinkedAccountAndTxnProvider &&
        other.accountId == accountId &&
        other.txnId == txnId &&
        other.debugReturnErrorAccount == debugReturnErrorAccount &&
        other.debugReturnErrorTransaction == debugReturnErrorTransaction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);
    hash = _SystemHash.combine(hash, txnId.hashCode);
    hash = _SystemHash.combine(hash, debugReturnErrorAccount.hashCode);
    hash = _SystemHash.combine(hash, debugReturnErrorTransaction.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
