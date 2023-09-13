import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

void showCategoryBottomSheet(BuildContext context, Category category) {
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
        child: CategoryBottomSheet(category),
      );
    },
  );
}

class CategoryBottomSheet extends ConsumerWidget {
  const CategoryBottomSheet(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primarySwatch = ColorTools.createPrimarySwatch(category.primaryColor.toColor);
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primarySwatch.shade500.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.category,
                    color: primarySwatch.shade500, // Use the darker shade for the icon color
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        category.description.value ?? 'No Description',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.purple[900]!.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.purple[100],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Icon(HeroIcons.pencil, color: Colors.purple[100]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                            title: 'Delete category?',
                            message: "This isn't a reversible action, think twice.",
                            onConfirm: () {
                              context.pop();
                            },
                            context: context,
                          );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      color: Colors.red[900]!.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red[100],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(HeroIcons.trash, color: Colors.red[100]),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          ExpandableCategoryMetadata(category),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

class ExpandableCategoryMetadata extends ConsumerWidget {
  const ExpandableCategoryMetadata(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(Icons.category),
            title: const Text(
              'Category Metadata',
            ),
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'id: ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[300],
                              ),
                          children: <TextSpan>[
                            TextSpan(text: category.id, style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: 'name: ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[300],
                              ),
                          children: <TextSpan>[
                            TextSpan(text: category.name, style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: 'description: ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[300],
                              ),
                          children: <TextSpan>[
                            TextSpan(
                                text: category.description.value ?? 'null',
                                style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: 'primaryColor: ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[300],
                              ),
                          children: <TextSpan>[
                            TextSpan(text: category.primaryColor, style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: 'parentId: ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[300],
                              ),
                          children: <TextSpan>[
                            TextSpan(
                                text: category.parentId ?? 'null', style: DefaultTextStyle.of(context).style),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
