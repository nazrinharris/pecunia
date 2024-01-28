import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/get_saved_databases.dart';
import 'package:pecunia/features/auth/usecases/get_saved_users.dart';

class SavedUsersListWidget extends ConsumerWidget {
  const SavedUsersListWidget({super.key, this.isDebugMode = false});

  final bool isDebugMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedUsers = ref.watch(getSavedUsersProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: switch (savedUsers) {
          AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
          AsyncError(:final Failure error) => Center(child: Text(error.message)),
          AsyncData(:final List<PecuniaUser> value) =>
            isDebugMode ? _DebugSavedUsersList(userList: value) : _SavedUsersList(userList: value),
          _ => const Text('Unexpected state'),
        },
      ),
    );
  }
}

class _SavedUsersList extends ConsumerWidget {
  const _SavedUsersList({required this.userList});

  final List<PecuniaUser> userList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, top: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            'Saved Users',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(),
        if (userList.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: userList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("${userList[index].email ?? 'Unknown Email'} - ${userList[index].username}"),
              subtitle: Text(
                userList[index].uid,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                    ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.login),
                onPressed: () {},
              ),
            ),
          ),
        if (userList.isEmpty)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'You have no saved users, try logging in or signing up!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DebugSavedUsersList extends ConsumerWidget {
  const _DebugSavedUsersList({required this.userList});

  final List<PecuniaUser> userList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databases = ref.watch(getSavedDatabasesProvider);

    return switch (databases) {
      AsyncLoading() => const Center(child: CupertinoActivityIndicator()),
      AsyncError(:final Failure error) => Center(child: Text(error.message)),
      AsyncData(value: final List<String> dbPathsList) => Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Saved Users',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            const Divider(),
            if (userList.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    final isUnknownUserType = userList[index].userType == UserType.unknown;
                    final user = userList[index];

                    return ListTile(
                      title: Text("${user.email ?? 'Unknown Email'} - ${user.username}"),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: dbPathsList.contains(user.uid)
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  dbPathsList.contains(user.uid) ? Icons.check : Icons.close,
                                  color: dbPathsList.contains(user.uid) ? Colors.green : Colors.red,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Database',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: dbPathsList.contains(user.uid) ? Colors.green : Colors.red,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: isUnknownUserType
                                ? 165
                                : user.userType == UserType.local
                                    ? 70
                                    : 80,
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: isUnknownUserType
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isUnknownUserType ? Icons.close : Icons.check,
                                  color: isUnknownUserType ? Colors.red : Colors.green,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isUnknownUserType ? 'Unknown User Type' : user.userType.typeAsString,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: isUnknownUserType ? Colors.red : Colors.green,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${user.uid.substring(0, 8)}...',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                ),
                          ),
                        ],
                      ),
                    );
                  }),
            if (userList.isEmpty)
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                child: Text(
                  'You have no saved users, try logging in or signing up!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                      ),
                ),
              ),
            if (dbPathsList.length > userList.length)
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'There are ${dbPathsList.length - userList.length} databases that are not associated with a user',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                      ),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      _ => const Text('Unexpected state'),
    };
  }
}
