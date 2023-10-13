import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/usecases/get_all_transactions.dart';
import 'package:simple_animations/simple_animations.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: RefreshIndicator(
      displacement: 100,
      onRefresh: () async {
        ref
          ..invalidate(getAllTransactionsProvider)
          ..invalidate(getAllAccountsProvider);
      },
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Finance',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      'Management',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const AddBudgetButton(),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    ));
  }
}

class AddBudgetButton extends HookConsumerWidget {
  const AddBudgetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = useState(Control.stop);

    return CustomAnimationBuilder(
      control: control.value,
      tween: MovieTween()
        ..tween(
          'scale',
          Tween<double>(begin: 1, end: 0.95),
          duration: const Duration(milliseconds: 100),
        )
        ..tween(
          'opacity',
          Tween<double>(begin: 1, end: 0.8),
          duration: const Duration(milliseconds: 100),
        ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Transform.scale(
        scale: value.get('scale'),
        child: Opacity(
          opacity: value.get('opacity'),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTapDown: (details) {
          control.value = Control.play;
        },
        onTapUp: (details) async {
          await HapticFeedback.lightImpact();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.playReverse;
          await Future<void>.delayed(const Duration(milliseconds: 100));
          control.value = Control.stop;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'Add Budget',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
