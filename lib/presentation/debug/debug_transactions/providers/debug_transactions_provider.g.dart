// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_transactions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createTransactionHash() => r'c4bf211f5007d7cc5a1653eed945d66bf2c5ed33';

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
String _$getAllAccountsHash() => r'c926777446f8213aa7df9b613e13c2806e39a07a';

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
    r'aa8764699f5541a0e149ab572ba24324528a268b';

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
