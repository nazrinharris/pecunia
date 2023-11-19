// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getIsFirstOpenHash() => r'b9c17eb71941b7fc2091c10157b8963c6fe013c8';

/// See also [getIsFirstOpen].
@ProviderFor(getIsFirstOpen)
final getIsFirstOpenProvider = AutoDisposeFutureProvider<Option<bool>>.internal(
  getIsFirstOpen,
  name: r'getIsFirstOpenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsFirstOpenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetIsFirstOpenRef = AutoDisposeFutureProviderRef<Option<bool>>;
String _$setIsFirstOpenHash() => r'33983010140d6dd6ac061fe82f78505ec37a2b4c';

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

typedef SetIsFirstOpenRef = AutoDisposeFutureProviderRef<void>;

/// See also [setIsFirstOpen].
@ProviderFor(setIsFirstOpen)
const setIsFirstOpenProvider = SetIsFirstOpenFamily();

/// See also [setIsFirstOpen].
class SetIsFirstOpenFamily extends Family<AsyncValue<void>> {
  /// See also [setIsFirstOpen].
  const SetIsFirstOpenFamily();

  /// See also [setIsFirstOpen].
  SetIsFirstOpenProvider call(
    bool value,
  ) {
    return SetIsFirstOpenProvider(
      value,
    );
  }

  @override
  SetIsFirstOpenProvider getProviderOverride(
    covariant SetIsFirstOpenProvider provider,
  ) {
    return call(
      provider.value,
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
  String? get name => r'setIsFirstOpenProvider';
}

/// See also [setIsFirstOpen].
class SetIsFirstOpenProvider extends AutoDisposeFutureProvider<void> {
  /// See also [setIsFirstOpen].
  SetIsFirstOpenProvider(
    this.value,
  ) : super.internal(
          (ref) => setIsFirstOpen(
            ref,
            value,
          ),
          from: setIsFirstOpenProvider,
          name: r'setIsFirstOpenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setIsFirstOpenHash,
          dependencies: SetIsFirstOpenFamily._dependencies,
          allTransitiveDependencies:
              SetIsFirstOpenFamily._allTransitiveDependencies,
        );

  final bool value;

  @override
  bool operator ==(Object other) {
    return other is SetIsFirstOpenProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
