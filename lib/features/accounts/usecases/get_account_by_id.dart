import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_account_by_id.g.dart';

// TODO: Remove debug throw error boolean and code
@riverpod
Future<Account> getAccountById(GetAccountByIdRef ref, String accountId, {bool? debugReturnError}) async {
  if (debugReturnError != null && debugReturnError) {
    await Future<void>.delayed(const Duration(seconds: 2));

    return Future<Account>.error(AccountsFailure.unknown(
      stackTrace: StackTrace.current,
      message: 'Account retrieval failed',
    ));
  }

  watchAllWritesFutureProvider<Account>(ref);

  return (await ref.read(accountsRepoProvider).getAccountById(accountId).run()).fold(
    (l) => Future<Account>.error(l, l.stackTrace),
    (r) => r,
  );
}
