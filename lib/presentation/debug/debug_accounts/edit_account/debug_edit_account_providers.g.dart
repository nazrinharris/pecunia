// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_edit_account_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editAccountFormHash() => r'f1383345770097af1e69d6999c6d72b54676a836';

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

typedef EditAccountFormRef = AutoDisposeProviderRef<FormGroup>;

/// See also [editAccountForm].
@ProviderFor(editAccountForm)
const editAccountFormProvider = EditAccountFormFamily();

/// See also [editAccountForm].
class EditAccountFormFamily extends Family<FormGroup> {
  /// See also [editAccountForm].
  const EditAccountFormFamily();

  /// See also [editAccountForm].
  EditAccountFormProvider call({
    required String name,
    required String currency,
    required String initialBalance,
    String? description,
  }) {
    return EditAccountFormProvider(
      name: name,
      currency: currency,
      initialBalance: initialBalance,
      description: description,
    );
  }

  @override
  EditAccountFormProvider getProviderOverride(
    covariant EditAccountFormProvider provider,
  ) {
    return call(
      name: provider.name,
      currency: provider.currency,
      initialBalance: provider.initialBalance,
      description: provider.description,
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
  String? get name => r'editAccountFormProvider';
}

/// See also [editAccountForm].
class EditAccountFormProvider extends AutoDisposeProvider<FormGroup> {
  /// See also [editAccountForm].
  EditAccountFormProvider({
    required this.name,
    required this.currency,
    required this.initialBalance,
    this.description,
  }) : super.internal(
          (ref) => editAccountForm(
            ref,
            name: name,
            currency: currency,
            initialBalance: initialBalance,
            description: description,
          ),
          from: editAccountFormProvider,
          name: r'editAccountFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editAccountFormHash,
          dependencies: EditAccountFormFamily._dependencies,
          allTransitiveDependencies:
              EditAccountFormFamily._allTransitiveDependencies,
        );

  final String name;
  final String currency;
  final String initialBalance;
  final String? description;

  @override
  bool operator ==(Object other) {
    return other is EditAccountFormProvider &&
        other.name == name &&
        other.currency == currency &&
        other.initialBalance == initialBalance &&
        other.description == description;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);
    hash = _SystemHash.combine(hash, initialBalance.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$editAccountHash() => r'f100ad4f0685cfcb8259ef0c90088db63cc1940a';

/// See also [EditAccount].
@ProviderFor(EditAccount)
final editAccountProvider =
    AutoDisposeAsyncNotifierProvider<EditAccount, Option<Unit>>.internal(
  EditAccount.new,
  name: r'editAccountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$editAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EditAccount = AutoDisposeAsyncNotifier<Option<Unit>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
