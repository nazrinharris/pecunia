import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_account_by_id.g.dart';

@riverpod
Future<Account> getAccountById(GetAccountByIdRef ref, String accountId) async {
  return (await ref.read(accountsRepoProvider).getAccountById(accountId).run()).fold(
    (l) => Future<Account>.error(l, l.stackTrace),
    (r) => r,
  );
}
