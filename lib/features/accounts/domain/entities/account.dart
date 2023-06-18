import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required String id, // Unique identifier for the account
    required String creatorUid, // The uid of the user who created the account
    required String name, // The name of the account
    required double initialBalance, // The initial balance when the account was created
    required double balance, // The current balance of the account
    required String currency, // The currency used by the account
    required DateTime createdOn, // The date when the account was created
    String? description, // Description of the account
  }) = _Account;

  const Account._();

  factory Account.fromDTO(AccountDTO dto) {
    return Account(
      id: dto.id,
      creatorUid: dto.creatorUid,
      name: dto.name,
      initialBalance: dto.initialBalance,
      balance: dto.balance,
      currency: dto.currency,
      createdOn: dto.createdOn,
      description: dto.description,
    );
  }
}