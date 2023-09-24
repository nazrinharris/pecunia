import 'package:pecunia/features/categories/domain/categories_repo.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_categories.g.dart';

@riverpod
Future<List<Category>> getAllCategories(
  GetAllCategoriesRef ref,
) async {
  return (await ref.read(categoriesRepoProvider).getAllCategories().run()).fold(
    (l) => Future<List<Category>>.error(l, l.stackTrace),
    (r) => r,
  );
}
