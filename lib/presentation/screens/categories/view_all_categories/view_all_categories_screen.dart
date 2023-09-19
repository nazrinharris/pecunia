// TODO: Remove lint ignore
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/categories/usecases/create_category.dart';
import 'package:pecunia/features/categories/usecases/delete_category.dart';
import 'package:pecunia/features/categories/usecases/get_all_categories.dart';
import 'package:pecunia/features/categories/usecases/update_category.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories/category_bottom_sheet_widget.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories/create_category_form_widget.dart';

class ViewAllCategories extends HookConsumerWidget {
  const ViewAllCategories({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(createCategoryProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "Uh oh, can't create category...",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Category created successfully!',
              );
          ref.invalidate(getAllCategoriesProvider);
        }
      })
      ..listen(updateCategoryProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "Uh oh, can't update the category...",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Category updated successfully!',
              );
          ref.invalidate(getAllCategoriesProvider);
        }
      })
      ..listen(deleteCategoryProvider, (prev, next) {
        if (next is AsyncError) {
          ref.read(pecuniaDialogsProvider).showFailureDialog(
                title: "Uh oh, can't delete the category...",
                failure: next.error as Failure?,
              );
        }
        if (next is AsyncData<Option<Unit>> && next.value.isSome()) {
          context.pop();
          ref.read(pecuniaDialogsProvider).showSuccessDialog(
                title: 'Category deleted successfully!',
              );
          ref.invalidate(getAllCategoriesProvider);
        }
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showCreateCategoryBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const CategoriesContent(),
    );
  }
}

class CategoriesContent extends ConsumerWidget {
  const CategoriesContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesValue = ref.watch(getAllCategoriesProvider);
    return switch (categoriesValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final Failure error) => Center(child: Text(error.toString())),
      AsyncData(:final List<Category> value) when value.isNotEmpty => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final category = value[index];
            return CategoryListTile(category: category);
          },
        ),
      AsyncData(:final List<Category> value) when value.isEmpty => const Center(
          child: Text('No categories found'),
        ),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(int.parse(category.primaryColor, radix: 16));
    final primarySwatch = ColorTools.createPrimarySwatch(primaryColor);

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primarySwatch.shade500.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          category.icon,
          color: primarySwatch.shade500, // Use the darker shade for the icon color
        ),
      ),
      title: Text(
        category.name,
      ),
      subtitle: Text(category.description.toString(),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white.withOpacity(0.5),
              )),
      onTap: () {
        showCategoryBottomSheet(context, category);

        // Add your onTap functionality here
        debugPrint('Category ID: ${category.id}');
        debugPrint('Category Name: ${category.name}');
        debugPrint('Category Description: ${category.description}');
        debugPrint('Category Primary Color: ${category.primaryColor}');
        debugPrint('Category Icon: ${category.icon}');
        debugPrint('Category Parent ID: ${category.parentId}');
      },
    );
  }
}
