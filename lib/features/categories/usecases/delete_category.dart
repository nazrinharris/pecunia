import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/categories/domain/categories_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_category.g.dart';

@riverpod
class DeleteCategory extends _$DeleteCategory {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteCategory({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final failureOrUnit = await ref.read(categoriesRepoProvider).deleteCategory(id).run();

    failureOrUnit.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (unit) => state = AsyncValue.data(Option.of(unit)),
    );
  }
}
