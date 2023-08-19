import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'watch_accounts.g.dart';

@riverpod
Stream<Either<AccountsFailure, List<Account>>> watchAccounts(WatchAccountsRef ref) {
  return ref.watch(accountsRepoProvider).watchAccounts();
}
