part of 'transaction.dart';

/// [FundDetails] is a value object that encapsulates the details of a transaction.
///
/// Note: Direct interaction with this class's fields (`baseAmount/Currency`, `targetAmount/Currency`) is discouraged.
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
/// - In a multi-currency transaction, any one or two (but not all) out of [exchangeRate], [targetAmount],
///   and [targetCurrency] are provided.
/// - The provided target amount significantly differs from the computed target amount.
/// - The transaction type is invalid when calling [transactionAmount] or [transactionCurrency].
@freezed
class FundDetails with _$FundDetails {
  @Assert(
      'exchangeRate != null && targetAmount != null && targetCurrency != null || exchangeRate == null && targetAmount == null && targetCurrency == null',
      'Invalid multi-currency fields. Either provide all fields or none')
  const factory FundDetails({
    required double baseAmount,
    required Currency baseCurrency,
    required TransactionType transactionType,
    required double? exchangeRate,
    required double? targetAmount,
    required Currency? targetCurrency,
  }) = _FundDetails;

  factory FundDetails.fromDTO(TransactionDTO dto) {
    if ((dto.exchangeRate != null || dto.targetAmount != null || dto.targetCurrency != null) &&
        !(dto.exchangeRate != null && dto.targetAmount != null && dto.targetCurrency != null)) {
      throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.invalidMultiCurrencyFields,
      );
    }

    return FundDetails(
      baseAmount: dto.baseAmount,
      baseCurrency: PecuniaCurrencies.fromString(dto.baseCurrency),
      exchangeRate: dto.exchangeRate,
      targetAmount: dto.targetAmount,
      targetCurrency: dto.targetCurrency == null ? null : PecuniaCurrencies.fromString(dto.targetCurrency!),
      transactionType: TransactionType.fromString(dto.transactionType),
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

  /// The amount that was either received or paid out in the transaction.
  /// For debit transactions, this is the `targetAmount`.
  /// For credit transactions, this is the `baseAmount`.
  /// In single currency transactions, it's the `baseAmount` in all cases.
  double get exchangedAmount {
    switch (transactionType) {
      case TransactionType.debit:
        return targetAmount ?? baseAmount;
      case TransactionType.credit:
        return baseAmount;
    }
  }

  /// The currency that was either received or paid out in the transaction.
  /// For debit transactions, this is the `targetCurrency`.
  /// For credit transactions, this is the `baseCurrency`.
  /// In single currency transactions, it's the `baseCurrency` in all cases.
  Currency get exchangedCurrency {
    switch (transactionType) {
      case TransactionType.debit:
        return targetCurrency ?? baseCurrency;
      case TransactionType.credit:
        return baseCurrency;
    }
  }

  Currency get transactionCurrency {
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
