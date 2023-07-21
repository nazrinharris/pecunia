import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:uuid/uuid.dart';

part 'transaction.freezed.dart';

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
  }) =>
      Transaction(
        id: uuid.v4(),
        creatorUid: creatorUid,
        name: name,
        transactionDescription: transactionDescription,
        transactionDate: transactionDate.toUtc(),
        accountId: accountId,
        fundDetails: fundDetails,
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
    );
  }

  TransactionDTO toDTO() {
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
      baseCurrency: fundDetails.baseCurrency,
      exchangeRate: fundDetails.exchangeRate,
      targetAmount: fundDetails.targetAmount,
      targetCurrency: fundDetails.targetCurrency,
    );
  }
}

/// [FundDetails] is a value object that encapsulates the details of a transaction.
///
/// Note: Direct interaction with this class's fields is discouraged.
/// For transaction calculations, use the [transactionAmount] getter.
///
/// [transactionAmount] Logic:
/// This getter is designed to abstract the determination of the "real" amount in the transaction
/// based on the transaction type. In a debit transaction, money is taken from the base currency
/// account, hence the `baseAmount` is considered the real transaction amount.
/// In a credit transaction, money is added to the target currency account. If there's a target
/// amount (in multi-currency transactions), it's considered the real transaction amount;
/// otherwise, the `baseAmount` is used (in single-currency transactions).
///
/// To retrieve the main currency associated with this transaction, use the [transactionCurrency] getter.
///
/// If a transaction is single-currency, ensure that [exchangeRate], [targetAmount], and [targetCurrency]
/// are null when creating a new instance.
///
/// For multi-currency transactions, [exchangeRate], [targetAmount], and [targetCurrency] must all
/// be provided. The provided target amount must closely match the computed target amount
/// (baseAmount * exchangeRate) within a small tolerance to account for potential floating point errors.
///
/// Throws [TransactionsException] if:
/// * In a multi-currency transaction, any one or two (but not all) out of [exchangeRate], [targetAmount],
///   and [targetCurrency] are provided.
/// * The provided target amount significantly differs from the computed target amount.
/// * The transaction type is invalid when calling [transactionAmount] or [transactionCurrency].
@freezed
class FundDetails with _$FundDetails {
  const factory FundDetails({
    required double baseAmount,
    required String baseCurrency,
    required TransactionType transactionType,
    required double? exchangeRate,
    required double? targetAmount,
    required String? targetCurrency,
  }) = _FundDetails;

  factory FundDetails.fromDTO(TransactionDTO dto) {
    if ((dto.exchangeRate != null || dto.targetAmount != null || dto.targetCurrency != null) &&
        !(dto.exchangeRate != null && dto.targetAmount != null && dto.targetCurrency != null)) {
      throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.invalidMultiCurrencyFields,
        transactionsAction: TransactionsAction.fundDetailsFromDTO,
      );
    }

    if (dto.exchangeRate != null && dto.targetAmount != null) {
      final computedTargetAmount = dto.baseAmount * dto.exchangeRate!;
      const epsilon = 0.001; // Small tolerance to handle potential floating point errors

      print('baseAmount: ${dto.baseAmount}');
      print('exchangeRate: ${dto.exchangeRate}');
      print('targetAmount: ${dto.targetAmount}');
      print('computedTargetAmount: $computedTargetAmount');

      if ((computedTargetAmount - dto.targetAmount!).abs() > epsilon) {
        throw TransactionsException(
          stackTrace: StackTrace.current,
          errorType: TransactionsErrorType.invalidExchangedAmount,
          transactionsAction: TransactionsAction.fundDetailsFromDTO,
        );
      }
    }

    return FundDetails(
      baseAmount: dto.baseAmount,
      baseCurrency: dto.baseCurrency,
      exchangeRate: dto.exchangeRate,
      targetAmount: dto.targetAmount,
      targetCurrency: dto.targetCurrency,
      transactionType: TransactionType.fromString(dto.transactionType, TransactionsAction.unknown),
    );
  }

  const FundDetails._();

  double get transactionAmount {
    switch (transactionType) {
      case TransactionType.debit:
        // For debit transactions, the transaction amount is always the baseAmount
        return baseAmount;
      case TransactionType.credit:
        // For credit transactions, the transaction amount is the targetAmount
        // If targetAmount is not set (e.g., in single currency transactions), it is the baseAmount
        return targetAmount ?? baseAmount;
    }
  }

  String get transactionCurrency {
    switch (transactionType) {
      case TransactionType.debit:
        // For debit transactions, the transaction currency is always the baseCurrency
        return baseCurrency;
      case TransactionType.credit:
        // For credit transactions, the transaction currency is the targetCurrency
        // If targetCurrency is not set (e.g., in single currency transactions), it is the baseCurrency
        return targetCurrency ?? baseCurrency;
    }
  }

  bool get isMultiCurrency => exchangeRate != null && targetAmount != null && targetCurrency != null;
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
