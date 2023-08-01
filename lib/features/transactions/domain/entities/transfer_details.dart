part of 'transaction.dart';

@freezed
class TransferDetails with _$TransferDetails {
  @Assert(
      'linkedAccountId != null && linkedTransactionId != null || linkedAccountId == null && linkedTransactionId == null',
      'Either provide all fields or none')
  const factory TransferDetails({
    required String linkedAccountId,
    required String linkedTransactionId,
  }) = _TransferDetails;

  const TransferDetails._();

  factory TransferDetails.fromDTO(TransactionDTO dto) {
    return TransferDetails(
      linkedAccountId: dto.linkedAccountId!,
      linkedTransactionId: dto.linkedTransactionId!,
    );
  }
}
