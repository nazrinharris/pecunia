import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/usecases/get_all_accounts.dart';
import 'package:pecunia/features/transactions/usecases/get_all_transactions.dart';
import 'package:pecunia/presentation/screens/shared/recent_txn_list.dart';
import 'package:simple_animations/simple_animations.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: RefreshIndicator.adaptive(
      displacement: 100,
      onRefresh: () async {
        ref
          ..invalidate(getAllTransactionsProvider)
          ..invalidate(getAllAccountsProvider);
      },
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          PlayAnimationBuilder(
            tween: MovieTween()
              ..tween(
                'opacity',
                Tween<double>(begin: 0, end: 1),
                curve: Curves.easeOutExpo,
                duration: const Duration(milliseconds: 600),
              )
              ..tween(
                'position',
                Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero),
                curve: Curves.easeOutQuad,
                duration: const Duration(milliseconds: 600),
              ),
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
            builder: (context, value, child) => Transform.translate(
              offset: value.get('position'),
              child: Opacity(
                opacity: value.get('opacity'),
                child: child,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's good",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  Text(
                    'Heisenberg',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          PlayAnimationBuilder(
            tween: MovieTween()
              ..tween(
                'opacity',
                Tween<double>(begin: 0, end: 1),
                curve: Curves.easeOutExpo,
                duration: const Duration(milliseconds: 600),
              )
              ..tween(
                'position',
                Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero),
                curve: Curves.easeOutQuad,
                duration: const Duration(milliseconds: 600),
              ),
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 300),
            builder: (context, value, child) => Transform.translate(
              offset: value.get('position'),
              child: Opacity(
                opacity: value.get('opacity'),
                child: child,
              ),
            ),
            child: const RecentTxnList(maxTxnShown: 4),
          )
        ],
      ),
    ));
  }
}
