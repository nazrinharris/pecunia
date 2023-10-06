import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:pecunia/presentation/dialogs/pecunia_dialogs.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text('Change Password', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // TODO: Implement change password functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text('Privacy Policy', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // TODO: Implement navigation to privacy policy
            },
          ),
          ListTile(
            leading: const Icon(Icons.gavel),
            title: Text('Terms and Conditions', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              // TODO: Implement navigation to terms and conditions
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            onTap: () {
              ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                    title: 'Are you sure you want to logout?',
                    icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
                    onConfirm: () {
                      ref.read(authRepoProvider).logout(const Session(isValid: true));
                      context.goNamed('start');
                    },
                    context: context,
                  );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: Text('Navigate to Debug Mode', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              context.pushNamed('debug-login');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
