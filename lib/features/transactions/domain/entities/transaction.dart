import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/errors/transactions_errors/transactions_errors.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:uuid/uuid.dart';

part 'transaction.freezed.dart';

enum TransactionType {
  debit('debit'),
  credit('credit');

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

  factory Transaction.fromDTO(TransactionDTO dto, TransactionsAction action) {
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

/// Value object for the details of a transaction
///
/// Note: You should NOT use the fields of this class directly. When the transaction is required for
/// calculations, use [transactionAmount]
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
      const epsilon = 1e-6; // Small tolerance to handle potential floating point errors

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
    // Determine if this is a credit or debit transaction
    if (transactionType == TransactionType.debit) {
      // For debit transactions, the transaction amount is always the baseAmount
      return baseAmount;
    } else if (transactionType == TransactionType.credit) {
      // For credit transactions, the transaction amount is the targetAmount
      // If targetAmount is not set (e.g., in single currency transactions), it is the baseAmount
      return targetAmount ?? baseAmount;
    } else {
      throw TransactionsException(
        stackTrace: StackTrace.current,
        errorType: TransactionsErrorType.invalidType,
        transactionsAction: TransactionsAction.getTransactionAmount,
      );
    }
  }
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
