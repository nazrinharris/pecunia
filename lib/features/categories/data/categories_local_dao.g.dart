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
    r'2792d66da19b18fb7dcd99222f552fc9de05d8e8';

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
