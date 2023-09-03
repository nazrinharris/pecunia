import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/categories/domain/categories_repo.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_categories.g.dart';

@riverpod
class GetAllCategories extends _$GetAllCategories {
  @override
  Future<Option<List<Category>>> build() async {
    return const Option.none();
  }

  Future<void> getAllCategories() async {
    state = const AsyncValue.loading();

    final failureOrCategories = await ref.read(categoriesRepoProvider).getAllCategories().run();

    failureOrCategories.fold(
      (failure) => state = AsyncValue.error(failure, failure.stackTrace),
      (categories) => state = AsyncValue.data(Option.of(categories)),
    );
  }
}
