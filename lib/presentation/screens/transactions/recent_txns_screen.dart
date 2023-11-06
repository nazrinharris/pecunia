import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/presentation/widgets/transactions/recent_txn_list.dart';

class RecentTxnsScreen extends HookConsumerWidget {
  const RecentTxnsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.pop,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const RecentTxnList(
            elevation: 0,
            showViewMoreButton: false,
            showTitle: false,
            horizontalMargin: 0,
          ),
        ],
      ),
    );
  }
}
