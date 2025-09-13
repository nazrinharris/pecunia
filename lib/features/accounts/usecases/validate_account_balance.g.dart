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

/// See also [validateAccountBalance].
@ProviderFor(validateAccountBalance)
const validateAccountBalanceProvider = ValidateAccountBalanceFamily();

/// See also [validateAccountBalance].
class ValidateAccountBalanceFamily
    extends Family<AsyncValue<(bool isValid, double actualBalance)>> {
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
    extends AutoDisposeFutureProvider<(bool isValid, double actualBalance)> {
  /// See also [validateAccountBalance].
  ValidateAccountBalanceProvider(
    Account account,
  ) : this._internal(
          (ref) => validateAccountBalance(
            ref as ValidateAccountBalanceRef,
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
          account: account,
        );

  ValidateAccountBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.account,
  }) : super.internal();

  final Account account;

  @override
  Override overrideWith(
    FutureOr<(bool isValid, double actualBalance)> Function(
            ValidateAccountBalanceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateAccountBalanceProvider._internal(
        (ref) => create(ref as ValidateAccountBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        account: account,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<(bool isValid, double actualBalance)>
      createElement() {
    return _ValidateAccountBalanceProviderElement(this);
  }

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ValidateAccountBalanceRef
    on AutoDisposeFutureProviderRef<(bool isValid, double actualBalance)> {
  /// The parameter `account` of this provider.
  Account get account;
}

class _ValidateAccountBalanceProviderElement
    extends AutoDisposeFutureProviderElement<
        (bool isValid, double actualBalance)> with ValidateAccountBalanceRef {
  _ValidateAccountBalanceProviderElement(super.provider);

  @override
  Account get account => (origin as ValidateAccountBalanceProvider).account;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
