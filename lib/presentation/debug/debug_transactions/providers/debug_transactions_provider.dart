import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_transactions_provider.g.dart';

@riverpod
class ChosenAccount extends _$ChosenAccount {
  @override
  Option<Account> build() {
    return const Option.none();
  }

  void updateChosenAccount(List<Account> accountsList, String chosenAccountId) {
    final chosenAccount = accountsList.firstWhere((account) => account.id == chosenAccountId);
    state = Option.of(chosenAccount);
  }
}
