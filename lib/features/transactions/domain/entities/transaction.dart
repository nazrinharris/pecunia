import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';

part 'transaction.freezed.dart';

enum TransactionType {
  debit('debit'),
  credit('credit');

  const TransactionType(this.typeAsString);

  final String typeAsString;

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
      (element) => element.typeAsString == value,
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
    required TransactionType type,
    required FundDetails fundDetails,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.fromDTO(TransactionDTO dto) {
    return Transaction(
      id: dto.id,
      creatorUid: dto.creatorUid,
      name: dto.name,
      transactionDescription: TransactionDescription(dto.description),
      transactionDate: dto.transactionDate,
      accountId: dto.accountId,
      type: TransactionType.fromString(dto.transactionType),
      fundDetails: FundDetails.fromDTO(dto),
    );
  }

  TransactionDTO toDTO(Transaction txn) {
    return TransactionDTO(
      id: txn.id,
      creatorUid: txn.creatorUid,
      name: txn.name,
      transactionDate: txn.transactionDate,
      accountId: txn.accountId,
      transactionType: txn.type.typeAsString,
      originalAmount: txn.fundDetails.originalAmount,
      originalCurrency: txn.fundDetails.originalCurrency,
      exchangeRate: txn.fundDetails.exchangeRate,
      exchangedToAmount: txn.fundDetails.exchangedToAmount,
      exchangedToCurrency: txn.fundDetails.exchangedToCurrency,
    );
  }
}

@freezed
class FundDetails with _$FundDetails {
  const factory FundDetails({
    required double originalAmount,
    required String originalCurrency,
    double? exchangeRate,
    double? exchangedToAmount,
    String? exchangedToCurrency,
  }) = _FundDetails;

  factory FundDetails.fromDTO(TransactionDTO dto) {
    return FundDetails(
      originalAmount: dto.originalAmount,
      originalCurrency: dto.originalCurrency,
      exchangeRate: dto.exchangeRate,
      exchangedToAmount: dto.exchangedToAmount,
      exchangedToCurrency: dto.exchangedToCurrency,
    );
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
}
