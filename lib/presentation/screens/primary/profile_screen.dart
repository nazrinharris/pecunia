import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/get_logged_in_user.dart';
import 'package:pecunia/presentation/widgets/common/scale_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getLoggedInUserProvider);

    return Scaffold(
        body: ListView(
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
                  switch (user) {
                    AsyncLoading() => const SizedBox.shrink(),
                    AsyncError(:final Failure error) => Text(
                        error.message,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    AsyncData(:final Option<PecuniaUser> value) => Text(
                        value.fold(() => '', (t) => t.username),
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    _ => Text(
                        'Unknown State',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                  },
                  Text(
                    'Welcome to your crib',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  context.pushNamed('settings');
                },
                icon: const Icon(Icons.settings),
              )
            ],
          ),
        ),
        const ProfileMetadataCard(),
        const SizedBox(height: 14),
        const Divider(),
        const ProfileActionsButtons(),
      ],
    ));
  }
}

class ProfileMetadataCard extends ConsumerWidget {
  const ProfileMetadataCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getLoggedInUserProvider);

    return switch (user) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final Failure error) => Center(child: Text(error.toString())),
      AsyncData(:final Option<PecuniaUser> value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                    text: 'uid: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: value.match(() => 'null', (t) => t.uid),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 4),
                  RichText(
                      text: TextSpan(
                    text: 'username: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: value.match(() => 'null', (t) => t.username),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 4),
                  RichText(
                      text: TextSpan(
                    text: 'dateCreated: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: value.match(() => 'null', (t) => t.dateCreated.toString()),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 4),
                  RichText(
                      text: TextSpan(
                    text: 'userType: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: value.match(() => 'null', (t) => t.userType.typeAsString),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      _ => const Center(child: Text('Something went wrong')),
    };
  }
}

class ProfileActionsButtons extends ConsumerWidget {
  const ProfileActionsButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ScaleButton(
          onTap: () {
            context.pushNamed('view-all-categories');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              color: Colors.orange[600]!.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  children: [
                    Icon(Icons.sell, color: Colors.orange[300], size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'View All Categories',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.orange[300],
                          ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.orange[300]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
