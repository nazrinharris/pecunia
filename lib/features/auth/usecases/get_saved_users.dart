import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_users.g.dart';

@riverpod
Future<List<PecuniaUser>> getSavedUsers(GetSavedUsersRef ref) async {
  return (await ref.read(authRepoProvider).getSavedUsers().run()).fold(
    (l) => Future<List<PecuniaUser>>.error(l, l.stackTrace),
    (r) => r,
  );
}
