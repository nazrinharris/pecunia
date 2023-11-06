import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/core/shared/description.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:uuid/uuid.dart';

part 'fund_details.dart';
part 'transaction.freezed.dart';
part 'transfer_details.dart';

typedef TransactionId = String;

enum TransactionType {
  credit('credit'),
  debit('debit');

  const TransactionType(this.typeAsString);

  final String typeAsString;

  static TransactionType fromString(String inputType) {
    return TransactionType.values.firstWhere(
      (element) => element.typeAsString.toLowerCase() == inputType.toLowerCase(),
      orElse: () => throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.invalidType,
      ),
    );
  }

  /// Returns a more detailed string representation of the transaction type.
  ///
  /// For each transaction type, this method appends additional context
  /// to the basic type. For instance, a credit transaction is mapped
  /// to 'Income (Credit)' and a debit transaction to 'Expense (Debit)'.
  /// This method is useful when a more descriptive representation of
  /// the transaction type is needed.
  String toDescription() {
    switch (this) {
      case TransactionType.credit:
        return 'Income';
      case TransactionType.debit:
        return 'Expense';
    }
  }

  /// Returns a user-friendly string representation of the transaction type.
  ///
  /// This method maps each transaction type to a string that is meant to be
  /// displayed in the user interface. It simplifies the transaction types to
  /// 'Income' for credit transactions and 'Expense' for debit transactions.
  /// Use this method when you need a simple, human-readable representation
  /// of the transaction type.
  String toDisplayName() {
    switch (this) {
      case TransactionType.credit:
        return 'Income';
      case TransactionType.debit:
        return 'Expense';
    }
  }

  bool isCredit() => this == TransactionType.credit;
  bool isDebit() => this == TransactionType.debit;
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String creatorUid,
    required String name,
    required Description transactionDescription,
    required DateTime transactionDate,
    required String accountId,
    required FundDetails fundDetails,
    required TransferDetails? transferDetails,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.newTransaction({
    required String creatorUid,
    required String name,
    required Description transactionDescription,
    required DateTime transactionDate,
    required String accountId,
    required FundDetails fundDetails,
    required Uuid uuid,
    required TransferDetails? transferDetails,
  }) =>
      Transaction(
        id: uuid.v4(),
        creatorUid: creatorUid,
        name: name,
        transactionDescription: transactionDescription,
        transactionDate: transactionDate.toUtc(),
        accountId: accountId,
        fundDetails: fundDetails,
        transferDetails: transferDetails,
      );

  factory Transaction.fromDTO(TransactionDTO dto) {
    return Transaction(
        id: dto.id,
        creatorUid: dto.creatorUid,
        name: dto.name,
        transactionDescription: Description(dto.description),
        transactionDate: dto.transactionDate.toUtc(),
        accountId: dto.accountId,
        fundDetails: FundDetails.fromDTO(dto),
        transferDetails: TransferDetails.isTransfer(dto) ? TransferDetails.fromDTO(dto) : null);
  }

  TransactionDTO toDTO() {
    if (fundDetails.exchangeRate != null && fundDetails.targetAmount != null) {
      final computedTargetAmount = fundDetails.baseAmount * fundDetails.exchangeRate!;
      const epsilon = 0.00001; // Small tolerance to handle potential floating point errors

      final difference = (computedTargetAmount - fundDetails.targetAmount!).abs();

      if (difference > epsilon) {
        throw TransactionsException(
            stackTrace: StackTrace.current,
            errorType: TransactionsErrorType.invalidExchangedAmount,
            message:
                'Stored target amount (${fundDetails.targetAmount} ${fundDetails.targetCurrency}) does not match computed target amount ($computedTargetAmount ${fundDetails.targetCurrency}). \nBecause (${fundDetails.baseAmount} ${fundDetails.baseCurrency} * ${fundDetails.exchangeRate} should equal to $computedTargetAmount ${fundDetails.targetCurrency}) \nWhich has a difference of $difference, which is greater than the tolerance of $epsilon');
      }
    }

    return TransactionDTO(
      id: id,
      creatorUid: creatorUid,
      name: name,
      description: transactionDescription.value,
      transactionDate: transactionDate.toUtc(),
      accountId: accountId,
      transactionType: fundDetails.transactionType.typeAsString,
      transactionAmount: fundDetails.transactionAmount,
      baseAmount: fundDetails.baseAmount,
      baseCurrency: fundDetails.baseCurrency.code,
      exchangeRate: fundDetails.exchangeRate,
      targetAmount: fundDetails.targetAmount,
      targetCurrency: fundDetails.targetCurrency?.code,
      linkedAccountId: transferDetails?.linkedAccountId,
      linkedTransactionId: transferDetails?.linkedTransactionId,
      transferDescription: transferDetails?.transferDescription.value,
    );
  }

  bool get isTransferTransaction => transferDetails != null;

  /// Provide `null` for both [defaultSourceTxnId] and [defaultDestinationTxnId] to generate a new transfer transaction.
  ///
  /// To sort of update a transfer transacton, provide the [defaultSourceTxnId] and [defaultDestinationTxnId] of the transfer transaction.
  static fp.Either<TransactionsFailure, ({Transaction sourceTxn, Transaction destinationTxn})>
      generateTransferTxnPair({
    required Account sourceAccount,
    required Account destinationAccount,
    required double sourceTransactionAmount,
    required double? destinationTransactionAmount,
    required double? exchangeRate,
    required String? transferDescription,
    required Uuid uuid,
    required String? defaultSourceTxnId,
    required String? defaultDestinationTxnId,

    // TODO: Remove debug fields
    Transaction? oldSourceTxn,
    Transaction? oldDestinationTxn,
  }) {
    final sourceTxnId = defaultSourceTxnId ?? uuid.v4();
    final destinationTxnId = defaultDestinationTxnId ?? uuid.v4();
    final isMultiCurrencyTransfer = sourceAccount.currency != destinationAccount.currency;

    // ! Checks that both destinationTransactionAmount and exchangeRate is null or both are not null.
    if ((destinationTransactionAmount == null && exchangeRate != null) ||
        (destinationTransactionAmount != null && exchangeRate == null)) {
      return fp.Either.left(TransactionsFailure(
        message: TransactionsErrorType.invalidMultiCurrencyFields.message,
        errorType: TransactionsErrorType.invalidMultiCurrencyFields,
        stackTrace: StackTrace.current,
      ));
    }

    // ! Checks that the exchangeRate isn't null if the source and destination currencies are different.
    if (exchangeRate == null && sourceAccount.currency != destinationAccount.currency) {
      return fp.Either.left(TransactionsFailure(
        message: TransactionsErrorType.missingExchangeRateForDifferentCurrencies.message,
        errorType: TransactionsErrorType.missingExchangeRateForDifferentCurrencies,
        stackTrace: StackTrace.current,
      ));
    }

    // ! Checks whether the source and destination accounts are the same.
    if (sourceAccount.id == destinationAccount.id) {
      return fp.Either.left(TransactionsFailure(
        message: TransactionsErrorType.sameSourceAndDestinationAccount.message,
        errorType: TransactionsErrorType.sameSourceAndDestinationAccount,
        stackTrace: StackTrace.current,
      ));
    }

    // * Sets the fields for the FundDetails of the transaction (extracted for legibility)
    // * Note that a single-currency transaction assumes [exchangeRate], [targetAmount], and [targetCurrency] are null (and vice versa).
    final sourceTxnFundDetails = FundDetails(
      transactionType: TransactionType.debit,
      baseAmount: sourceTransactionAmount,
      baseCurrency: sourceAccount.currency,
      exchangeRate: exchangeRate,
      targetAmount: destinationTransactionAmount,
      targetCurrency: isMultiCurrencyTransfer ? destinationAccount.currency : null,
    );
    final destinationTxnFundDetails = FundDetails(
      transactionType: TransactionType.credit,
      baseAmount: sourceTransactionAmount,
      baseCurrency: sourceAccount.currency,
      exchangeRate: exchangeRate,
      targetAmount: isMultiCurrencyTransfer ? destinationTransactionAmount : null,
      targetCurrency: isMultiCurrencyTransfer ? destinationAccount.currency : null,
    );

    final sourceTxn = Transaction(
      id: sourceTxnId,
      creatorUid: sourceAccount.creatorUid,
      name: 'Transfer to ${destinationAccount.id}',
      transactionDescription: Description(null),
      transactionDate: DateTime.now(),
      accountId: sourceAccount.id,
      fundDetails: sourceTxnFundDetails,
      transferDetails: TransferDetails(
        linkedTransactionId: destinationTxnId,
        linkedAccountId: destinationAccount.id,
        transferDescription: TransferDescription(transferDescription),
      ),
    );

    final destinationTxn = Transaction(
      id: destinationTxnId,
      creatorUid: destinationAccount.creatorUid,
      name: 'Transfer from ${sourceAccount.id}',
      transactionDescription: Description(null),
      transactionDate: DateTime.now(),
      accountId: destinationAccount.id,
      fundDetails: destinationTxnFundDetails,
      transferDetails: TransferDetails(
        linkedTransactionId: sourceTxnId,
        linkedAccountId: sourceAccount.id,
        transferDescription: TransferDescription(transferDescription),
      ),
    );

    // TODO: Remove debug print
    debugPrint('''
      -----------------------------------------------------------------------
      newSourceTxn: ${sourceTxn.fundDetails.transactionAmount}
      oldSourceTxn: ${oldSourceTxn?.fundDetails.transactionAmount}
      newDestinationTxn: ${destinationTxn.fundDetails.transactionAmount}
      oldDestinationTxn: ${oldDestinationTxn?.fundDetails.transactionAmount}
      -----------------------------------------------------------------------
''');

    return fp.Either.right((sourceTxn: sourceTxn, destinationTxn: destinationTxn));
  }
}
