part of 'transaction.dart';

@freezed
class TransferDetails with _$TransferDetails {
  @Assert(
      'linkedAccountId != null && linkedTransactionId != null || linkedAccountId == null && linkedTransactionId == null',
      'Either provide all fields or none')
  const factory TransferDetails({
    required String linkedAccountId,
    required String linkedTransactionId,
    required TransferDescription transferDescription,
  }) = _TransferDetails;

  const TransferDetails._();

  // TODO: Make the null check on a seperate if-conditional and throw a [TransactionsException]
  factory TransferDetails.fromDTO(TransactionDTO dto) {
    return TransferDetails(
      linkedAccountId: dto.linkedAccountId!,
      linkedTransactionId: dto.linkedTransactionId!,
      transferDescription: TransferDescription(dto.transferDescription),
    );
  }
}

/// Value object for the description of a transaction
/// The description can be null, so check for that.
@immutable
class TransferDescription {
  TransferDescription(String? input) : value = _validateInput(input);

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

    return other is TransferDescription && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
