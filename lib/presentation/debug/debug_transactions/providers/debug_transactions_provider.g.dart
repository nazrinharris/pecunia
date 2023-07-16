// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTransactionHash() => r'46878cf4233312761a19d599f6bcf74d61ba26eb';

/// See also [CreateTransaction].
@ProviderFor(CreateTransaction)
final createTransactionProvider =
    AutoDisposeAsyncNotifierProvider<CreateTransaction, Option<Unit>>.internal(
  CreateTransaction.new,
  name: r'createTransactionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createTransactionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateTransaction = AutoDisposeAsyncNotifier<Option<Unit>>;
String _$deleteTransactionHash() => r'82bf45e658fe725498fdff2580cd84f134e3018c';

/// See also [DeleteTransaction].
@ProviderFor(DeleteTransaction)
final deleteTransactionProvider =
    AutoDisposeAsyncNotifierProvider<DeleteTransaction, Option<Unit>>.internal(
  DeleteTransaction.new,
  name: r'deleteTransactionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteTransactionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteTransaction = AutoDisposeAsyncNotifier<Option<Unit>>;
String _$chosenAccountHash() => r'07a76ac6883341355177c3e7304e26d67ef3c88c';

/// See also [ChosenAccount].
@ProviderFor(ChosenAccount)
final chosenAccountProvider =
    AutoDisposeNotifierProvider<ChosenAccount, Option<Account>>.internal(
  ChosenAccount.new,
  name: r'chosenAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chosenAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChosenAccount = AutoDisposeNotifier<Option<Account>>;
String _$getAllAccountsHash() => r'cfd8e053ab67fdfb5601c3a828cfa7edf8c28323';

/// See also [GetAllAccounts].
@ProviderFor(GetAllAccounts)
final getAllAccountsProvider =
    AutoDisposeAsyncNotifierProvider<GetAllAccounts, List<Account>>.internal(
  GetAllAccounts.new,
  name: r'getAllAccountsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllAccountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetAllAccounts = AutoDisposeAsyncNotifier<List<Account>>;
String _$getAllTransactionsHash() =>
    r'e3c1ed01fb3d8b43396376f78acd96109f43577f';

/// See also [GetAllTransactions].
@ProviderFor(GetAllTransactions)
final getAllTransactionsProvider = AutoDisposeAsyncNotifierProvider<
    GetAllTransactions, List<Transaction>>.internal(
  GetAllTransactions.new,
  name: r'getAllTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetAllTransactions = AutoDisposeAsyncNotifier<List<Transaction>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
