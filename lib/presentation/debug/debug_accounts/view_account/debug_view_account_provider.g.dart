// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_view_account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountByIdHash() => r'7a55f8fb20a48ba0ecc8f61f96d2cffa1502e498';

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
    String accountId,
  ) {
    return GetAccountByIdProvider(
      accountId,
    );
  }

  @override
  GetAccountByIdProvider getProviderOverride(
    covariant GetAccountByIdProvider provider,
  ) {
    return call(
      provider.accountId,
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
    this.accountId,
  ) : super.internal(
          (ref) => getAccountById(
            ref,
            accountId,
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

  @override
  bool operator ==(Object other) {
    return other is GetAccountByIdProvider && other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$validateAccountBalanceHash() =>
    r'e27e608721fa2b782d10e00d32f3160c51def678';
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

String _$getTransactionsByAccountIdHash() =>
    r'8d9e085ee16a6ad1ff0ddd3f2e0aee78d699fa12';
typedef GetTransactionsByAccountIdRef
    = AutoDisposeFutureProviderRef<List<Transaction>>;

/// See also [getTransactionsByAccountId].
@ProviderFor(getTransactionsByAccountId)
const getTransactionsByAccountIdProvider = GetTransactionsByAccountIdFamily();

/// See also [getTransactionsByAccountId].
class GetTransactionsByAccountIdFamily
    extends Family<AsyncValue<List<Transaction>>> {
  /// See also [getTransactionsByAccountId].
  const GetTransactionsByAccountIdFamily();

  /// See also [getTransactionsByAccountId].
  GetTransactionsByAccountIdProvider call(
    String accountId,
  ) {
    return GetTransactionsByAccountIdProvider(
      accountId,
    );
  }

  @override
  GetTransactionsByAccountIdProvider getProviderOverride(
    covariant GetTransactionsByAccountIdProvider provider,
  ) {
    return call(
      provider.accountId,
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
  String? get name => r'getTransactionsByAccountIdProvider';
}

/// See also [getTransactionsByAccountId].
class GetTransactionsByAccountIdProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [getTransactionsByAccountId].
  GetTransactionsByAccountIdProvider(
    this.accountId,
  ) : super.internal(
          (ref) => getTransactionsByAccountId(
            ref,
            accountId,
          ),
          from: getTransactionsByAccountIdProvider,
          name: r'getTransactionsByAccountIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTransactionsByAccountIdHash,
          dependencies: GetTransactionsByAccountIdFamily._dependencies,
          allTransitiveDependencies:
              GetTransactionsByAccountIdFamily._allTransitiveDependencies,
        );

  final String accountId;

  @override
  bool operator ==(Object other) {
    return other is GetTransactionsByAccountIdProvider &&
        other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$editTransactionHash() => r'03148ed3f73d58f99759f78078ebe38f63574c8f';

/// See also [EditTransaction].
@ProviderFor(EditTransaction)
final editTransactionProvider =
    AutoDisposeAsyncNotifierProvider<EditTransaction, Option<Unit>>.internal(
  EditTransaction.new,
  name: r'editTransactionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$editTransactionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EditTransaction = AutoDisposeAsyncNotifier<Option<Unit>>;
String _$isCurrencyExchangeEnabledHash() =>
    r'b837d7a33d2be701c26897ef2cc6211b0e25b3d5';

/// See also [IsCurrencyExchangeEnabled].
@ProviderFor(IsCurrencyExchangeEnabled)
final isCurrencyExchangeEnabledProvider =
    AutoDisposeNotifierProvider<IsCurrencyExchangeEnabled, bool>.internal(
  IsCurrencyExchangeEnabled.new,
  name: r'isCurrencyExchangeEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCurrencyExchangeEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsCurrencyExchangeEnabled = AutoDisposeNotifier<bool>;
String _$fundDetailsStateHash() => r'706582867712735c3985753d6a2834bdd888117c';

/// See also [FundDetailsState].
@ProviderFor(FundDetailsState)
final fundDetailsStateProvider = AutoDisposeNotifierProvider<FundDetailsState,
    FundDetailsFieldState>.internal(
  FundDetailsState.new,
  name: r'fundDetailsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fundDetailsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FundDetailsState = AutoDisposeNotifier<FundDetailsFieldState>;
String _$fundDetailsControllerHash() =>
    r'fe01c64198699354eefd9dc8180a36f12141dea8';

abstract class _$FundDetailsController
    extends BuildlessAutoDisposeNotifier<FundDetailsFieldState> {
  late final FormGroup form;

  FundDetailsFieldState build(
    FormGroup form,
  );
}

/// See [createTransactionForm]
///
/// Copied from [FundDetailsController].
@ProviderFor(FundDetailsController)
const fundDetailsControllerProvider = FundDetailsControllerFamily();

/// See [createTransactionForm]
///
/// Copied from [FundDetailsController].
class FundDetailsControllerFamily extends Family<FundDetailsFieldState> {
  /// See [createTransactionForm]
  ///
  /// Copied from [FundDetailsController].
  const FundDetailsControllerFamily();

  /// See [createTransactionForm]
  ///
  /// Copied from [FundDetailsController].
  FundDetailsControllerProvider call(
    FormGroup form,
  ) {
    return FundDetailsControllerProvider(
      form,
    );
  }

  @override
  FundDetailsControllerProvider getProviderOverride(
    covariant FundDetailsControllerProvider provider,
  ) {
    return call(
      provider.form,
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
  String? get name => r'fundDetailsControllerProvider';
}

/// See [createTransactionForm]
///
/// Copied from [FundDetailsController].
class FundDetailsControllerProvider extends AutoDisposeNotifierProviderImpl<
    FundDetailsController, FundDetailsFieldState> {
  /// See [createTransactionForm]
  ///
  /// Copied from [FundDetailsController].
  FundDetailsControllerProvider(
    this.form,
  ) : super.internal(
          () => FundDetailsController()..form = form,
          from: fundDetailsControllerProvider,
          name: r'fundDetailsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fundDetailsControllerHash,
          dependencies: FundDetailsControllerFamily._dependencies,
          allTransitiveDependencies:
              FundDetailsControllerFamily._allTransitiveDependencies,
        );

  final FormGroup form;

  @override
  bool operator ==(Object other) {
    return other is FundDetailsControllerProvider && other.form == form;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, form.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FundDetailsFieldState runNotifierBuild(
    covariant FundDetailsController notifier,
  ) {
    return notifier.build(
      form,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
