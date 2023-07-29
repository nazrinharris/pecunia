import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_account.g.dart';

@riverpod
class EditAccount extends _$EditAccount {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editAccount({
    required Account oldAccount,
    required String name,
    required double initialBalance,
    String? description,
  }) async {
    state = const AsyncValue.loading();

    final newAccount = oldAccount.copyWith(
      name: name,
      initialBalance: initialBalance,
      description: AccountDescription(description),
    );

    (await ref.watch(accountsRepoProvider).updateAccountDetails(newAccount).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}
