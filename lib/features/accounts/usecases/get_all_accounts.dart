import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_accounts.g.dart';

@riverpod
Future<List<Account>> getAllAccounts(GetAllAccountsRef ref) async {
  watchAllWritesFutureProvider<List<Account>>(ref);

  return (await ref.read(accountsRepoProvider).getAccounts().run()).fold(
    (l) => Future<List<Account>>.error(l, l.stackTrace),
    (r) => r,
  );
}
