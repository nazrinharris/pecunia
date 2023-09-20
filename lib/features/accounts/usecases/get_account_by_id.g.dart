// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountByIdHash() => r'0ccc38f53e8a78b56bf9c4822f2993e96b510a71';

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

typedef GetAccountByIdRef = AutoDisposeFutureProviderRef<Account>;

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
    this.accountId, {
    this.debugReturnError,
  }) : super.internal(
          (ref) => getAccountById(
            ref,
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
        );

  final String accountId;
  final bool? debugReturnError;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
