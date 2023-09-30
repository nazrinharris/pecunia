import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/pecunia_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user.g.dart';

@riverpod
class GetLoggedInUser extends _$GetLoggedInUser {
  @override
  Future<Option<PecuniaUser>> build() async {
    return _getLoggedInUser();
  }

  Future<Option<PecuniaUser>> _getLoggedInUser() async {
    return (await ref.read(authRepoProvider).getLoggedInUser().run()).fold(
      (l) => Future<Option<PecuniaUser>>.error(l, l.stackTrace),
      (r) => r,
    );
  }
}
