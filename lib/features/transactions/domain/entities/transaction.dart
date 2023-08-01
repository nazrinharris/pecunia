import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:uuid/uuid.dart';

part 'transaction.freezed.dart';
part 'transfer_details.dart';
part 'fund_details.dart';

enum TransactionType {
  credit('credit'),
  debit('debit');

  const TransactionType(this.typeAsString);

  final String typeAsString;

  static TransactionType fromString(String inputType, TransactionsAction action) {
    return TransactionType.values.firstWhere(
      (element) => element.typeAsString.toLowerCase() == inputType.toLowerCase(),
      orElse: () => throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.invalidType,
        transactionsAction: action,
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
        return 'Income (Credit)';
      case TransactionType.debit:
        return 'Expense (Debit)';
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
    required TransactionDescription transactionDescription,
    required DateTime transactionDate,
    required String accountId,
    required FundDetails fundDetails,
    required TransferDetails? transferDetails,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.newTransaction({
    required String creatorUid,
    required String name,
    required TransactionDescription transactionDescription,
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
      transactionDescription: TransactionDescription(dto.description),
      transactionDate: dto.transactionDate.toUtc(),
      accountId: dto.accountId,
      fundDetails: FundDetails.fromDTO(dto),
      transferDetails: TransferDetails.fromDTO(dto),
    );
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
            transactionsAction: TransactionsAction.unknown,
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
    );
  }

  bool get isTransferTransaction => transferDetails != null;
}

/// Value object for the description of a transaction
/// The description can be null, so check for that.
@immutable
class TransactionDescription {
  TransactionDescription(String? input) : value = _validateInput(input);

  final String? value;

  @override
  String toString() => value ?? 'No Description';

  static String? _validateInput(String? input) {
    if (input == null || input.trim().isEmpty) {
      return null;
    }
    return input;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionDescription && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
