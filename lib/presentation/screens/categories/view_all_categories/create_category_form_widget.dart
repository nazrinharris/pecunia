// TODO: Remove lint ignore
// ignore_for_file: prefer_const_constructors

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/categories/usecases/create_category.dart';

class CreateCategoryBottomSheet extends HookConsumerWidget {
  const CreateCategoryBottomSheet({
    super.key,
    this.disableCloseButton = false,
  });

  final bool disableCloseButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final primaryColorController = useState<Color>(Theme.of(context).colorScheme.primary);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
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
                    'Create Category',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.purple[100]),
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
            ColorPickerWidget(
              initialColor: primaryColorController.value,
              onColorChanged: (color) => primaryColorController.value = color,
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
                  await ref.read(createCategoryProvider.notifier).createCategory(
                        name: nameController.text,
                        primaryColor: primaryColorController.value.hexAlpha,
                        description: descriptionController.text,
                        icon: null,
                        parentId: null,
                      );
                }
              },
              child: const Text('Create Category'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    required this.initialColor,
    required this.onColorChanged,
    super.key,
  });

  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newColor = await showDialog<Color>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pick a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  color: initialColor,
                  subheading: const Text('Shades'),
                  onColorChanged: onColorChanged,
                  enableShadesSelection: false,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        if (newColor != null) {
          onColorChanged(newColor);
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: initialColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Tap to choose category color',
            style: TextStyle(
              color: initialColor.useWhiteForeground() ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
            ),
          ),
        ),
      ),
    );
  }
}
