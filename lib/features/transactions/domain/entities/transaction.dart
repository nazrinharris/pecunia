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
    required TransactionType type,
    required FundDetails fundDetails,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.newTransaction({
    required String creatorUid,
    required String name,
    required TransactionDescription transactionDescription,
    required DateTime transactionDate,
    required String accountId,
    required TransactionType type,
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
        type: type,
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
      type: TransactionType.fromString(dto.transactionType, action),
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
      transactionType: type.typeAsString,
      originalAmount: fundDetails.originalAmount,
      originalCurrency: fundDetails.originalCurrency,
      exchangeRate: fundDetails.exchangeRate,
      exchangedToAmount: fundDetails.exchangedToAmount,
      exchangedToCurrency: fundDetails.exchangedToCurrency,
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionDescription && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
