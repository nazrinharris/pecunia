import 'package:pecunia/features/auth/domain/auth_repo.dart';
import 'package:pecunia/features/auth/domain/entities/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout.g.dart';

@riverpod
Future<void> logout(LogoutRef ref) async {
  return (await ref.watch(authRepoProvider).logout(const Session(isValid: false)).run()).fold(
    (l) => Future.error(l, l.stackTrace),
    (r) => r,
  );
}
