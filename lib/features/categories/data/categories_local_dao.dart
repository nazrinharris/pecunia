import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/categories_errors/categories_errors.dart';
import 'package:pecunia/core/infrastructure/drift/icon_data_converter.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_local_dao.g.dart';

@riverpod
CategoriesLocalDAO categoriesLocalDAO(CategoriesLocalDAORef ref) =>
    CategoriesLocalDAO(ref.watch(pecuniaDBProvider));

@DataClassName('CategoryDTO')
class CategoriesTable extends Table {
  // ========================= Seperation For Brevity =========================
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 500).nullable()();
  TextColumn get primaryColor => text()();
  // ========================= Seperation For Brevity =========================
  TextColumn get icon => text().map(const IconDataConverter()).nullable()();
  TextColumn get parentId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [CategoriesTable])
class CategoriesLocalDAO extends DatabaseAccessor<PecuniaDB> with _$CategoriesLocalDAOMixin {
  CategoriesLocalDAO(super.db);

  TaskEither<CategoriesFailure, Unit> createCategory(Category category) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await into(categoriesTable).insert(category.toDTO());
        return unit;
      }),
      mapDriftToCategoriesFailure,
    );
  }

  TaskEither<CategoriesFailure, Unit> updateCategory(Category category) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await update(categoriesTable).replace(category.toDTO());
        return unit;
      }),
      mapDriftToCategoriesFailure,
    );
  }

  TaskEither<CategoriesFailure, Unit> deleteCategory(String id) {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        await (delete(categoriesTable)..where((category) => category.id.equals(id))).go();
        return unit;
      }),
      mapDriftToCategoriesFailure,
    );
  }

  TaskEither<CategoriesFailure, List<Category>> getAllCategories() {
    return TaskEither.tryCatch(
      () async => transaction(() async {
        final results = await select(categoriesTable).get();
        return results.map(Category.fromDTO).toList();
      }),
      mapDriftToCategoriesFailure,
    );
  }
}
