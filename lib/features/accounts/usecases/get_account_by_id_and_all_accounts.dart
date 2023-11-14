import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/usecases/watch_all_writes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_account_by_id_and_all_accounts.g.dart';

typedef AccountAndList = ({Account account, List<Account> accountsList});

@riverpod
Future<AccountAndList> getAccountByIdAndAllAccounts(
  GetAccountByIdAndAllAccountsRef ref,
  String accountId,
) async {
  watchAllWritesFutureProvider<AccountAndList>(ref);

  final repo = ref.watch(accountsRepoProvider);

  final results = await Future.wait([
    repo.getAccounts().run(),
    repo.getAccountById(accountId).run(),
  ]);

  final getAccountsResult = results[0];
  final getAccountByIdResult = results[1];

  if (getAccountsResult.isLeft()) {
    return Future<AccountAndList>.error(
      getAccountsResult.getLeft().fold(
            () => UnexpectedFailure(message: 'This should never happen.', stackTrace: StackTrace.current),
            (f) => f,
          ),
    );
  } else if (getAccountByIdResult.isLeft()) {
    return Future<AccountAndList>.error(
      getAccountByIdResult.getLeft().fold(
            () => UnexpectedFailure(message: 'This should never happen.', stackTrace: StackTrace.current),
            (f) => f,
          ),
    );
  }

  final accountsList = getAccountsResult
      .getOrElse((l) => throw CriticalException(stackTrace: StackTrace.current)) as List<Account>;
  final account = getAccountByIdResult
      .getOrElse((l) => throw CriticalException(stackTrace: StackTrace.current)) as Account;

  return (account: account, accountsList: accountsList);
}
