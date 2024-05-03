// TODO: Remove lint ignore
// ignore_for_file: prefer_const_constructors

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/util/extensions.dart';
import 'package:pecunia/features/categories/usecases/create_category.dart';

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
            children: const [
              CreateCategoryBottomSheet(),
              SizedBox(height: 64),
            ],
          ),
        ),
      );
    },
  );
}

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
    final iconController = useState<IconData>(Icons.question_mark);

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
                SizedBox(width: 14),
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
                  await ref.read(createCategoryProvider.notifier).createCategory(
                        name: nameController.text,
                        primaryColor: primaryColorController.value.hexAlpha,
                        description: descriptionController.text,
                        icon: iconController.value,
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
    return Material(
      color: initialColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.white.withOpacity(0.2),
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
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Tap to choose category color',
              style: TextStyle(
                color: initialColor.useWhiteForeground() ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconPickerWidget extends HookConsumerWidget {
  const IconPickerWidget({required this.color, required this.iconController, super.key});

  final Color color;
  final ValueNotifier<IconData> iconController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primarySwatch = ColorTools.createPrimarySwatch(color);

    return Material(
      borderRadius: BorderRadius.circular(28),
      color: primarySwatch.shade500.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () async {
          final icon = await showIconPicker(
            context,
            adaptiveDialog: true,
            iconPackModes: [IconPack.allMaterial, IconPack.cupertino],
            iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
          );

          if (icon != null) {
            iconController.value = icon;
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          child: Icon(
            iconController.value,
            size: 52,
            color: primarySwatch.shade500,
          ),
        ),
      ),
    );
  }
}
