import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/infrastructure/package_info/package_info.dart';
import 'package:pecunia/features/auth/usecases/logout.dart';
import 'package:pecunia/presentation/widgets/pecunia_dialogs.dart';

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
                    onConfirm: () async {
                      await ref.read(logoutProvider.future).then((value) => context.goNamed('start'));
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
              ref.read(pecuniaDialogsProvider).showConfirmationDialog(
                    title: 'Navigate to Debug Mode?',
                    message: 'This is only for testing purposes. Functionality is not guaranteed.',
                    onConfirm: () {
                      context.pushNamed('debug-login');
                    },
                    icon: Icon(Icons.bug_report, color: Theme.of(context).colorScheme.error),
                    context: context,
                  );
            },
          ),
          const Divider(),
          const PecuniaAppMetadata(),
        ],
      ),
    );
  }
}

class PecuniaAppMetadata extends ConsumerWidget {
  const PecuniaAppMetadata({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfoValue = ref.watch(packageInfoProvider);

    return switch (packageInfoValue) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError(:final Exception error) => Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 64),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Pecunia',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! + 4,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! - 2,
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ],
          ),
        ),
      AsyncData(value: final packageInfo) => Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                packageInfo.appName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize! + 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                packageInfo.packageName,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                    ),
              ),
              Text(
                'Version ${packageInfo.version}+${packageInfo.buildNumber}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                    ),
              ),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
