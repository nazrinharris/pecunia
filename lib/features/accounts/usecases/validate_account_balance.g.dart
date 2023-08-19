// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_account_balance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$validateAccountBalanceHash() =>
    r'e27e608721fa2b782d10e00d32f3160c51def678';

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

typedef ValidateAccountBalanceRef
    = AutoDisposeFutureProviderRef<(bool, double)>;

/// See also [validateAccountBalance].
@ProviderFor(validateAccountBalance)
const validateAccountBalanceProvider = ValidateAccountBalanceFamily();

/// See also [validateAccountBalance].
class ValidateAccountBalanceFamily extends Family<AsyncValue<(bool, double)>> {
  /// See also [validateAccountBalance].
  const ValidateAccountBalanceFamily();

  /// See also [validateAccountBalance].
  ValidateAccountBalanceProvider call(
    Account account,
  ) {
    return ValidateAccountBalanceProvider(
      account,
    );
  }

  @override
  ValidateAccountBalanceProvider getProviderOverride(
    covariant ValidateAccountBalanceProvider provider,
  ) {
    return call(
      provider.account,
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
  String? get name => r'validateAccountBalanceProvider';
}

/// See also [validateAccountBalance].
class ValidateAccountBalanceProvider
    extends AutoDisposeFutureProvider<(bool, double)> {
  /// See also [validateAccountBalance].
  ValidateAccountBalanceProvider(
    this.account,
  ) : super.internal(
          (ref) => validateAccountBalance(
            ref,
            account,
          ),
          from: validateAccountBalanceProvider,
          name: r'validateAccountBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateAccountBalanceHash,
          dependencies: ValidateAccountBalanceFamily._dependencies,
          allTransitiveDependencies:
              ValidateAccountBalanceFamily._allTransitiveDependencies,
        );

  final Account account;

  @override
  bool operator ==(Object other) {
    return other is ValidateAccountBalanceProvider && other.account == account;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
