// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$debugGetLocalUsersHash() =>
    r'baa2be1b20160f636cf11fa1b20824b0694f66ae';

/// See also [debugGetLocalUsers].
@ProviderFor(debugGetLocalUsers)
final debugGetLocalUsersProvider =
    AutoDisposeFutureProvider<List<PecuniaUser>>.internal(
  debugGetLocalUsers,
  name: r'debugGetLocalUsersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugGetLocalUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DebugGetLocalUsersRef = AutoDisposeFutureProviderRef<List<PecuniaUser>>;
String _$debugGetAllSessionsHash() =>
    r'364cd4c76f0925ff7d8d4d7ea09b285ce3154e51';

/// See also [debugGetAllSessions].
@ProviderFor(debugGetAllSessions)
final debugGetAllSessionsProvider =
    AutoDisposeFutureProvider<List<Session>>.internal(
  debugGetAllSessions,
  name: r'debugGetAllSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugGetAllSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DebugGetAllSessionsRef = AutoDisposeFutureProviderRef<List<Session>>;
String _$debugGetActiveSessionHash() =>
    r'9a02ec3cd7b1e8a470c959ddc7a8312c7047eb46';

/// See also [debugGetActiveSession].
@ProviderFor(debugGetActiveSession)
final debugGetActiveSessionProvider =
    AutoDisposeFutureProvider<Option<Session>>.internal(
  debugGetActiveSession,
  name: r'debugGetActiveSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugGetActiveSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DebugGetActiveSessionRef
    = AutoDisposeFutureProviderRef<Option<Session>>;
String _$navigateToDebugLocalDBHash() =>
    r'1b8043ac7036b81a6babfa33d88dc3106f466c55';

/// See also [NavigateToDebugLocalDB].
@ProviderFor(NavigateToDebugLocalDB)
final navigateToDebugLocalDBProvider =
    AutoDisposeAsyncNotifierProvider<NavigateToDebugLocalDB, bool>.internal(
  NavigateToDebugLocalDB.new,
  name: r'navigateToDebugLocalDBProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$navigateToDebugLocalDBHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NavigateToDebugLocalDB = AutoDisposeAsyncNotifier<bool>;
String _$debugLocalLoginWithEmailAndPasswordHash() =>
    r'bc89a6996ee260eb0820bd713638d83267af1336';

/// See also [DebugLocalLoginWithEmailAndPassword].
@ProviderFor(DebugLocalLoginWithEmailAndPassword)
final debugLocalLoginWithEmailAndPasswordProvider =
    AutoDisposeAsyncNotifierProvider<DebugLocalLoginWithEmailAndPassword,
        Option<PecuniaUser>>.internal(
  DebugLocalLoginWithEmailAndPassword.new,
  name: r'debugLocalLoginWithEmailAndPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugLocalLoginWithEmailAndPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DebugLocalLoginWithEmailAndPassword
    = AutoDisposeAsyncNotifier<Option<PecuniaUser>>;
String _$debugLocalRegisterWithEmailAndPasswordHash() =>
    r'647fae6fa74d5a5ced3ece4443213592860031fc';

/// See also [DebugLocalRegisterWithEmailAndPassword].
@ProviderFor(DebugLocalRegisterWithEmailAndPassword)
final debugLocalRegisterWithEmailAndPasswordProvider =
    AutoDisposeAsyncNotifierProvider<DebugLocalRegisterWithEmailAndPassword,
        Option<PecuniaUser>>.internal(
  DebugLocalRegisterWithEmailAndPassword.new,
  name: r'debugLocalRegisterWithEmailAndPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$debugLocalRegisterWithEmailAndPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DebugLocalRegisterWithEmailAndPassword
    = AutoDisposeAsyncNotifier<Option<PecuniaUser>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
