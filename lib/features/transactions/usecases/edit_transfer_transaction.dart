import 'package:fpdart/fpdart.dart';
import 'package:pecunia/core/errors/failures.dart';
import 'package:pecunia/core/infrastructure/uuid/pecunia_uuid.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_transfer_transaction.g.dart';

@riverpod
class EditTransferTransaction extends _$EditTransferTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editTransferTransaction({
    // New fields
    required Account sourceAccount,
    required Account destinationAccount,
    required double sourceTransactionAmount,
    required double? destinationTransactionAmount,
    required double? exchangeRate,
    required String transferDescription,

    // Old fields
    required Transaction oldSourceTxn,
    required Transaction oldDestinationTxn,
  }) async {
    state = const AsyncLoading();
    late final ({Transaction destinationTxn, Transaction sourceTxn}) txns;

    final result = Transaction.generateTransferTxnPair(
      sourceAccount: sourceAccount,
      destinationAccount: destinationAccount,
      sourceTransactionAmount: sourceTransactionAmount,
      destinationTransactionAmount: destinationTransactionAmount,
      exchangeRate: exchangeRate,
      transferDescription: transferDescription,
      uuid: ref.watch(uuidProvider),
      defaultSourceTxnId: oldSourceTxn.id,
      defaultDestinationTxnId: oldDestinationTxn.id,
      oldSourceTxn: oldSourceTxn,
      oldDestinationTxn: oldDestinationTxn,
    ).fold(
      (l) {
        state = AsyncError(l, l.stackTrace);
        return l;
      },
      (r) => r,
    );

    if (result is Failure) {
      return;
    } else {
      txns = result as ({Transaction destinationTxn, Transaction sourceTxn});
    }

    (await ref
            .read(transactionsRepoProvider)
            .editTransferTransaction(
              oldSourceTxn: oldSourceTxn,
              oldDestinationTxn: oldDestinationTxn,
              newSourceTxn: txns.sourceTxn,
              newDestinationTxn: txns.destinationTxn,
            )
            .run())
        .fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}
