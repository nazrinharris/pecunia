import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/categories_errors/categories_errors.dart';
import 'package:pecunia/features/categories/data/categories_local_dao.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_repo.g.dart';

@riverpod
CategoriesRepo categoriesRepo(CategoriesRepoRef ref) => CategoriesRepo(ref.watch(categoriesLocalDAOProvider));

class CategoriesRepo {
  CategoriesRepo(this.categoriesLocalDAO);

  final CategoriesLocalDAO categoriesLocalDAO;

  TaskEither<CategoriesFailure, Unit> createCategory(Category category) {
    return categoriesLocalDAO.createCategory(category);
  }

  TaskEither<CategoriesFailure, Unit> updateCategory(Category category) {
    return categoriesLocalDAO.updateCategory(category);
  }

  TaskEither<CategoriesFailure, Unit> deleteCategory(String id) {
    return categoriesLocalDAO.deleteCategory(id);
  }

  TaskEither<CategoriesFailure, List<Category>> getAllCategories() {
    return categoriesLocalDAO.getAllCategories();
  }
}
