import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/accounts/usecases/create_account.dart';
import 'package:pecunia/features/accounts/usecases/delete_account.dart';
import 'package:pecunia/features/accounts/usecases/edit_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_accounts.g.dart';

@riverpod
Future<List<Account>> getAllAccounts(GetAllAccountsRef ref) async {
  ref
    ..watch(createAccountProvider)
    ..watch(deleteAccountProvider)
    ..watch(editAccountProvider);

  return (await ref.read(accountsRepoProvider).getAccounts().run()).fold(
    (l) => Future<List<Account>>.error(l, l.stackTrace),
    (r) => r,
  );
}
