import 'package:flutter/material.dart';

class DebugThemeScreen extends StatelessWidget {
  const DebugThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final colorItems = [
      // Primary colors
      ColorItem('primary', colorScheme.primary),
      ColorItem('onPrimary', colorScheme.onPrimary),
      ColorItem('primaryContainer', colorScheme.primaryContainer),
      ColorItem('onPrimaryContainer', colorScheme.onPrimaryContainer),

      // Secondary colors
      ColorItem('secondary', colorScheme.secondary),
      ColorItem('onSecondary', colorScheme.onSecondary),
      ColorItem('secondaryContainer', colorScheme.secondaryContainer),
      ColorItem('onSecondaryContainer', colorScheme.onSecondaryContainer),

      // Tertiary colors
      ColorItem('tertiary', colorScheme.tertiary),
      ColorItem('onTertiary', colorScheme.onTertiary),
      ColorItem('tertiaryContainer', colorScheme.tertiaryContainer),
      ColorItem('onTertiaryContainer', colorScheme.onTertiaryContainer),

      // Error colors
      ColorItem('error', colorScheme.error),
      ColorItem('onError', colorScheme.onError),
      ColorItem('errorContainer', colorScheme.errorContainer),
      ColorItem('onErrorContainer', colorScheme.onErrorContainer),

      // Background colors
      ColorItem('background', colorScheme.surface),
      ColorItem('onBackground', colorScheme.onSurface),

      // Surface colors
      ColorItem('surface', colorScheme.surface),
      ColorItem('onSurface', colorScheme.onSurface),
      ColorItem('surfaceVariant', colorScheme.surfaceContainerHighest),
      ColorItem('onSurfaceVariant', colorScheme.onSurfaceVariant),

      // Additional surface colors
      ColorItem('inverseSurface', colorScheme.inverseSurface),
      ColorItem('onInverseSurface', colorScheme.onInverseSurface),
      ColorItem('surfaceTint', colorScheme.surfaceTint),

      // Outline colors
      ColorItem('outline', colorScheme.outline),
      ColorItem('outlineVariant', colorScheme.outlineVariant),

      // Other colors
      ColorItem('shadow', colorScheme.shadow),
      ColorItem('scrim', colorScheme.scrim),
      ColorItem('inversePrimary', colorScheme.inversePrimary),

      // Theme specific colors (not in ColorScheme)
      ColorItem('cardColor', theme.cardColor),
      ColorItem('dividerColor', theme.dividerColor),
      ColorItem('focusColor', theme.focusColor),
      ColorItem('hoverColor', theme.hoverColor),
      ColorItem('highlightColor', theme.highlightColor),
      ColorItem('splashColor', theme.splashColor),
      ColorItem('disabledColor', theme.disabledColor),
      ColorItem('canvasColor', theme.canvasColor),
      ColorItem('scaffoldBackground', theme.scaffoldBackgroundColor),
      ColorItem('dialogBackground', theme.dialogBackgroundColor),
      ColorItem('indicatorColor', theme.indicatorColor),
      ColorItem('hintColor', theme.hintColor),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Colors'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = colorItems[index];
                  return ColorCard(item: item);
                },
                childCount: colorItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorItem {
  final String name;
  final Color color;

  ColorItem(this.name, this.color);
}

class ColorCard extends StatelessWidget {
  final ColorItem item;

  const ColorCard({Key? key, required this.item}) : super(key: key);

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  void _copyToClipboard(BuildContext context, String text) {
    // In a real app, you'd use the clipboard package:
    // Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: $text'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _getContrastColor(item.color);
    final hexColor = _colorToHex(item.color);

    return InkWell(
      onTap: () => _copyToClipboard(context, 'colorScheme.${item.name}'),
      onLongPress: () => _copyToClipboard(context, hexColor),
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                hexColor,
                style: TextStyle(
                  color: textColor.withOpacity(0.8),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
