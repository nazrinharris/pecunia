// TODO: Remove lint ignore
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/categories/usecases/create_category.dart';
import 'package:pecunia/features/categories/usecases/get_all_categories.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories/create_category_form_widget.dart';

class ViewAllCategories extends HookConsumerWidget {
  const ViewAllCategories({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    ref.listen(createCategoryProvider, (prev, next) {
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
    });

    final categoriesValue = ref.watch(getAllCategoriesProvider);
    return switch (categoriesValue) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final Failure error) => Center(child: Text(error.toString())),
      AsyncData(:final List<Category> value) when value.isNotEmpty => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final category = value[index];
            return ListTile(
              title: Text(category.name),
              subtitle: Text(category.description.toString()),
            );
          },
        ),
      AsyncData(:final List<Category> value) when value.isEmpty => const Center(
          child: Text('No categories found'),
        ),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

void showCreateCategoryBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    showDragHandle: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(44),
    ),
    builder: (context) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CreateCategoryBottomSheet(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      );
    },
  );
}
