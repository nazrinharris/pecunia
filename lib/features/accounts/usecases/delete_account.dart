import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account.g.dart';

@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> deleteAccount(Account account) async {
    state = const AsyncValue.loading();

    (await ref.watch(accountsRepoProvider).deleteAccount(account).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}
