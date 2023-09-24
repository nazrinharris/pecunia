import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/categories/domain/categories_repo.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_category.g.dart';

@riverpod
class CreateCategory extends _$CreateCategory {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> createCategory({
    required String name,
    required String primaryColor,
    required String? description,
    required IconData? icon,
    required String? parentId,
  }) async {
    state = const AsyncValue.loading();

    final failureOrUnit = await ref
        .read(categoriesRepoProvider)
        .createCategory(Category.newCategory(
          uuid: ref.watch(uuidProvider),
          name: name,
          primaryColor: primaryColor,
          description: description,
          parentId: parentId,
          icon: icon,
        ))
        .run();

    failureOrUnit.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (unit) => state = AsyncValue.data(Option.of(unit)),
    );
  }
}
