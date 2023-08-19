import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'validate_account_balance.g.dart';

@riverpod
Future<(bool isValid, double actualBalance)> validateAccountBalance(
    ValidateAccountBalanceRef ref, Account account) async {
  return (await ref.read(accountsRepoProvider).validateAccountBalance(account).run()).match(
    (l) => Future<(bool isValid, double actualBalance)>.error(l, l.stackTrace),
    (r) => r,
  );
}
