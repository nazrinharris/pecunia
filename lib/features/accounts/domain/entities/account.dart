import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';
import 'package:pecunia/core/common/description.dart';
import 'package:pecunia/core/infrastructure/drift/pecunia_drift_db.dart';
import 'package:pecunia/core/infrastructure/money2/pecunia_currencies.dart';
import 'package:uuid/uuid.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String creatorUid,
    required String name,
    required double initialBalance,
    required double balance,
    required Currency currency,
    required DateTime createdOn,
    required Description description,
  }) = _Account;

  const Account._();

  factory Account.newAccount({
    required String creatorUid,
    required String name,
    required double initialBalance,
    required Currency currency,
    required DateTime createdOn,
    required Uuid uuid,
    required Description description,
  }) =>
      Account(
        id: uuid.v4(),
        creatorUid: creatorUid,
        name: name,
        initialBalance: initialBalance,
        balance: initialBalance,
        currency: currency,
        createdOn: createdOn,
        description: description,
      );

  factory Account.fromDTO(AccountDTO dto) {
    return Account(
      id: dto.id,
      creatorUid: dto.creatorUid,
      name: dto.name,
      initialBalance: dto.initialBalance,
      balance: dto.balance,
      currency: PecuniaCurrencies.fromString(dto.currency),
      createdOn: dto.createdOn.toUtc(),
      description: Description(dto.description),
    );
  }

  AccountDTO toDTO() {
    return AccountDTO(
      id: id,
      creatorUid: creatorUid,
      name: name,
      initialBalance: initialBalance,
      balance: balance,
      currency: currency.code,
      createdOn: createdOn.toUtc(),
      description: description.value,
    );
  }
}
