import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/categories/domain/entities/category.dart';
import 'package:pecunia/features/categories/usecases/update_category.dart';
import 'package:pecunia/presentation/screens/categories/view_all_categories/create_category_form_widget.dart';

void showEditCategoryFormWidget(BuildContext context, Category oldCategory) {
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
              EditCategoryBottomSheet(oldCategory: oldCategory),
              const SizedBox(height: 64),
            ],
          ),
        ),
      );
    },
  );
}

class EditCategoryBottomSheet extends HookConsumerWidget {
  const EditCategoryBottomSheet({
    required this.oldCategory,
    super.key,
    this.disableCloseButton = false,
  });

  final bool disableCloseButton;
  final Category oldCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final nameController = useTextEditingController(text: oldCategory.name);
    final descriptionController = useTextEditingController(text: oldCategory.description.value);
    final primaryColorController = useState<Color>(
        ColorTools.createPrimarySwatch(Color(int.parse(oldCategory.primaryColor, radix: 16))));
    final iconController = useState<IconData>(oldCategory.icon ?? Icons.question_mark);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: formKey.value,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Category',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.purple[100],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (!disableCloseButton)
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close, size: 28))
                ],
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'Enter a name for your category',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                } else if (value.length > 50) {
                  return 'Category name cannot exceed 50 characters';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter a description for your category',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && value.length > 500) {
                  return 'Description cannot exceed 500 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                IconPickerWidget(color: primaryColorController.value, iconController: iconController),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: const Text('Tap the icon to change it'),
                      ),
                      ColorPickerWidget(
                        initialColor: primaryColorController.value,
                        onColorChanged: (color) => primaryColorController.value = color,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary,
              )),
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (formKey.value.currentState!.validate()) {
                  await ref.read(updateCategoryProvider.notifier).updateCategory(
                        name: nameController.text,
                        primaryColor: primaryColorController.value.hexAlpha,
                        description: descriptionController.text,
                        icon: iconController.value,
                        parentId: null,
                        oldCategory: oldCategory,
                      );
                }
              },
              child: const Text('Update Category'),
            ),
          ],
        ),
      ),
    );
  }
}
