// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_local_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoriesLocalDAOMixin on DatabaseAccessor<PecuniaDB> {
  $CategoriesTableTable get categoriesTable => attachedDatabase.categoriesTable;
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoriesLocalDAOHash() =>
    r'face134f7fdf97748f8daa5cdbdd29791e7c99c3';

/// See also [categoriesLocalDAO].
@ProviderFor(categoriesLocalDAO)
final categoriesLocalDAOProvider =
    AutoDisposeProvider<CategoriesLocalDAO>.internal(
  categoriesLocalDAO,
  name: r'categoriesLocalDAOProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoriesLocalDAOHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CategoriesLocalDAORef = AutoDisposeProviderRef<CategoriesLocalDAO>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
