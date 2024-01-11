import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_users.g.dart';

@riverpod
Future<List<PecuniaUser>> getSavedUsers(GetSavedUsersRef ref) async {
  return [
    // PecuniaUser(
    //   uid: '12838012378071023',
    //   username: 'John Doe',
    //   email: 'johndoe@john.doe',
    //   dateCreated: DateTime.now(),
    // )
  ];
  // return (await ref.read(authRepoProvider).getSavedUsers().run()).fold(
  //   (l) => Future<List<PecuniaUser>>.error(l, l.stackTrace),
  //   (r) => r,
  // );
}
