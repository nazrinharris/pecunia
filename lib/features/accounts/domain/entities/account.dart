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

      /// This basically checks if the [desc] is an empty String, if it is, return a null value, else return the [desc].
      /// Best case scenario is [desc] is always null, but sometimes life doesn't go our way.
      /// (The UI sometimes give an empty String as the description, so we have to check for that) Might do something
      /// about it, but this is a stopgap measure.
      description: (dto.description?.isEmpty ?? true) ? null : dto.description,
    );
  }

  AccountDTO toDTO() {
    return AccountDTO(
      id: id,
      creatorUid: creatorUid,
      name: name,
      initialBalance: initialBalance,
      balance: balance,
      currency: currency,
      createdOn: createdOn,
      description: description,
    );
  }
}
