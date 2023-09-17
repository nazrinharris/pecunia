import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/common/description.dart';
import 'package:pecunia/features/categories/domain/categories_repo.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_category.g.dart';

@riverpod
class UpdateCategory extends _$UpdateCategory {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> updateCategory({
    required String name,
    required String primaryColor,
    required String? description,
    required String? icon,
    required String? parentId,
    required Category oldCategory,
  }) async {
    state = const AsyncValue.loading();

    final failureOrUnit = await ref
        .read(categoriesRepoProvider)
        .updateCategory(oldCategory.copyWith(
          name: name,
          primaryColor: primaryColor,
          description: Description(description),
          // TODO: Add icon argument once icon system is implemented
          parentId: parentId,
        ))
        .run();

    failureOrUnit.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (unit) => state = AsyncValue.data(Option.of(unit)),
    );
  }
}
