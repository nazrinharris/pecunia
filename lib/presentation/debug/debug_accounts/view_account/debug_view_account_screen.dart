import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';

class DebugViewAccountScreen extends ConsumerWidget {
  const DebugViewAccountScreen(this.account, {super.key});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Column(
              children: [
                const SizedBox(height: 34),
                RichText(
                  text: TextSpan(
                    text: 'Balance: ',
                    style: const TextStyle(fontSize: 22),
                    children: [
                      TextSpan(
                        text: account.balance.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' ${account.currency}'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    text: 'Initial Balance: ',
                    style: const TextStyle(fontSize: 22),
                    children: [
                      TextSpan(
                        text: account.balance.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' ${account.currency}'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 14),
                Text(
                  'Description: ${account.description ?? 'No description'}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 14),
                Text(
                  'Created on: ${account.createdOn}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 14),
                Text(
                  'Creator ID: ${account.creatorUid} \n Account ID: ${account.id}',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 14),
              ],
            )
          ],
        ),
      ),
    );
  }
}
