import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/accounts_errors/accounts_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/accounts/dao_tables/accounts_dao_tables.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'accounts_local_ds.g.dart';

@riverpod
AccountsLocalDS accountsLocalDS(AccountsLocalDSRef ref) => AccountsLocalDSImpl(
      accountsDAO: ref.watch(accountsDAOProvider),
      uuid: ref.watch(uuidProvider),
    );

abstract interface class AccountsLocalDS {
  TaskEither<AccountsFailure, List<AccountDTO>> getAccounts();
  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  });
}

class AccountsLocalDSImpl implements AccountsLocalDS {
  AccountsLocalDSImpl({
    required this.accountsDAO,
    required this.uuid,
  });
  final AccountsDAO accountsDAO;
  final Uuid uuid;

  @override
  TaskEither<AccountsFailure, List<AccountDTO>> getAccounts() {
    // TODO: implement getAccounts
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountsFailure, Unit> createAccount({
    required String name,
    required String creatorUid,
    required double initialBalance,
    required String currency,
    String? desc,
  }) {
    const currentAction = AccountsAction.createAccount;
    return TaskEither.tryCatch(
      () async {
        await accountsDAO.insertAccount(
          AccountDTO(
            id: uuid.v4(),
            creatorUid: creatorUid,
            name: name,
            initialBalance: initialBalance,
            balance: initialBalance,
            currency: currency,
            createdOn: DateTime.now(),
          ),
        );
        return unit;
      },
      (error, stackTrace) => AccountsFailure.unknown(
        stackTrace: stackTrace,
        message: AccountsErrorType.unknown.toString(),
        accountsAction: currentAction,
      ),
    );
  }
}
