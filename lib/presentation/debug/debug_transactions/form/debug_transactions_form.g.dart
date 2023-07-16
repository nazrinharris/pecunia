// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_transactions_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTransactionFormHash() =>
    r'0c092e7e3b326e5c41c3dd9ca4b8a68154b25721';

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

typedef CreateTransactionFormRef = AutoDisposeProviderRef<FormGroup>;

/// See also [createTransactionForm].
@ProviderFor(createTransactionForm)
const createTransactionFormProvider = CreateTransactionFormFamily();

/// See also [createTransactionForm].
class CreateTransactionFormFamily extends Family<FormGroup> {
  /// See also [createTransactionForm].
  const CreateTransactionFormFamily();

  /// See also [createTransactionForm].
  CreateTransactionFormProvider call({
    String? typeDefault,
    String? accountId,
  }) {
    return CreateTransactionFormProvider(
      typeDefault: typeDefault,
      accountId: accountId,
    );
  }

  @override
  CreateTransactionFormProvider getProviderOverride(
    covariant CreateTransactionFormProvider provider,
  ) {
    return call(
      typeDefault: provider.typeDefault,
      accountId: provider.accountId,
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
  String? get name => r'createTransactionFormProvider';
}

/// See also [createTransactionForm].
class CreateTransactionFormProvider extends AutoDisposeProvider<FormGroup> {
  /// See also [createTransactionForm].
  CreateTransactionFormProvider({
    this.typeDefault,
    this.accountId,
  }) : super.internal(
          (ref) => createTransactionForm(
            ref,
            typeDefault: typeDefault,
            accountId: accountId,
          ),
          from: createTransactionFormProvider,
          name: r'createTransactionFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createTransactionFormHash,
          dependencies: CreateTransactionFormFamily._dependencies,
          allTransitiveDependencies:
              CreateTransactionFormFamily._allTransitiveDependencies,
        );

  final String? typeDefault;
  final String? accountId;

  @override
  bool operator ==(Object other) {
    return other is CreateTransactionFormProvider &&
        other.typeDefault == typeDefault &&
        other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, typeDefault.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$editTransactionFormHash() =>
    r'36ad8b315f1da75560b9cc4dc8bd0f12ea33d649';
typedef EditTransactionFormRef = AutoDisposeProviderRef<FormGroup>;

/// See also [editTransactionForm].
@ProviderFor(editTransactionForm)
const editTransactionFormProvider = EditTransactionFormFamily();

/// See also [editTransactionForm].
class EditTransactionFormFamily extends Family<FormGroup> {
  /// See also [editTransactionForm].
  const EditTransactionFormFamily();

  /// See also [editTransactionForm].
  EditTransactionFormProvider call(
    Transaction txn,
    Account account,
  ) {
    return EditTransactionFormProvider(
      txn,
      account,
    );
  }

  @override
  EditTransactionFormProvider getProviderOverride(
    covariant EditTransactionFormProvider provider,
  ) {
    return call(
      provider.txn,
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
  String? get name => r'editTransactionFormProvider';
}

/// See also [editTransactionForm].
class EditTransactionFormProvider extends AutoDisposeProvider<FormGroup> {
  /// See also [editTransactionForm].
  EditTransactionFormProvider(
    this.txn,
    this.account,
  ) : super.internal(
          (ref) => editTransactionForm(
            ref,
            txn,
            account,
          ),
          from: editTransactionFormProvider,
          name: r'editTransactionFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editTransactionFormHash,
          dependencies: EditTransactionFormFamily._dependencies,
          allTransitiveDependencies:
              EditTransactionFormFamily._allTransitiveDependencies,
        );

  final Transaction txn;
  final Account account;

  @override
  bool operator ==(Object other) {
    return other is EditTransactionFormProvider &&
        other.txn == txn &&
        other.account == account;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, txn.hashCode);
    hash = _SystemHash.combine(hash, account.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
