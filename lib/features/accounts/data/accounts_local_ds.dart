import 'dart:async';

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
  Stream<Either<AccountsFailure, List<AccountDTO>>> watchAccounts();

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
    const currentAction = AccountsAction.getAccounts;
    return TaskEither.tryCatch(
      accountsDAO.getAllAccounts,
      (error, stackTrace) => mapDriftToFailure(currentAction, error, stackTrace),
    );
  }

  /// This honestly feels like a frankensteins job. I'm not sure if this is the
  /// right way to do it. But it works. So I'm going to leave it as is for now.
  ///
  /// Another solution is to simply return the pure stream, though I'm not sure
  /// on how I'd handle the errors in that case.
  @override
  Stream<Either<AccountsFailure, List<AccountDTO>>> watchAccounts() {
    const currentAction = AccountsAction.watchAccounts;
    return accountsDAO.watchAllAccounts().transform(StreamTransformer.fromHandlers(
          handleData: (listOfDTOs, sink) {
            sink.add(
              right(listOfDTOs),
            );
          },
          handleError: (error, stackTrace, sink) {
            sink.add(
              left(mapDriftToFailure(currentAction, error, stackTrace)),
            );
          },
        ));
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
            description: desc,
          ),
        );
        return unit;
      },
      (error, stackTrace) => mapDriftToFailure(currentAction, error, stackTrace),
    );
  }
}
