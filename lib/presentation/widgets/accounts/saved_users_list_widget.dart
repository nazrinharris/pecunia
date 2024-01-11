import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:pecunia/features/auth/usecases/get_saved_users.dart';

class SavedUsersListWidget extends ConsumerWidget {
  const SavedUsersListWidget({super.key});

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
          AsyncData(:final List<PecuniaUser> value) when value.isEmpty => const _SavedUsersList(userList: []),
          AsyncData(:final List<PecuniaUser> value) => _SavedUsersList(userList: value),
          _ => const Text('Unexpected state'),
        },
      ),
    );
  }
}

class _SavedUsersList extends StatelessWidget {
  const _SavedUsersList({required this.userList});

  final List<PecuniaUser> userList;

  @override
  Widget build(BuildContext context) {
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
            itemCount: userList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(userList[index].email!),
              subtitle: Text(userList[index].uid),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
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
