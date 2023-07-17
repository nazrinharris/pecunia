import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/features/transactions/domain/transactions_repo.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/create_txn_form_widget.dart';
import 'package:pecunia/presentation/debug/debug_accounts/view_account/debug_view_account_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_view_account_provider.g.dart';

@riverpod
Future<Account> getAccountById(GetAccountByIdRef ref, String accountId) async {
  return (await ref.read(accountsRepoProvider).getAccountById(accountId).run()).fold(
    (l) => Future<Account>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
Future<(bool isValid, double actualBalance)> validateAccountBalance(
    ValidateAccountBalanceRef ref, Account account) async {
  return (await ref.read(accountsRepoProvider).validateAccountBalance(account).run()).match(
    (l) => Future<(bool isValid, double actualBalance)>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
Future<List<Transaction>> getTransactionsByAccountId(
  GetTransactionsByAccountIdRef ref,
  String accountId,
) async {
  return (await ref.read(transactionsRepoProvider).getTrasactionsByAccount(accountId).run()).fold(
    (l) => Future<List<Transaction>>.error(l, l.stackTrace),
    (r) => r,
  );
}

@riverpod
class EditTransaction extends _$EditTransaction {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editTransaction({
    required Transaction oldTxn,
    required String txnName,
    required String? txnDescription,
    required String txnType,
    //  required String txnAccount, Commented out, because as of now, can't change account of a transaction
    required double txnAmount,
  }) async {
    state = const AsyncLoading();
    final newTxn = oldTxn.copyWith(
      name: txnName,
      transactionDescription: TransactionDescription(txnDescription),
      fundDetails: oldTxn.fundDetails.copyWith(
        baseAmount: txnAmount,
        transactionType: TransactionType.fromString(txnType, TransactionsAction.edit),
      ),
    );

    (await ref.read(transactionsRepoProvider).updateTransaction(newTxn: newTxn, oldTxn: oldTxn).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) {
        ref.invalidate(getTransactionsByAccountIdProvider(oldTxn.accountId));
        state = AsyncData(Option.of(r));
      },
    );
  }
}

FormGroup createTransactionForm({TransactionType? typeDefault, String? accountId}) {
  return fb.group({
    CreateFields.name:
        fb.control('', [Validators.required, Validators.minLength(1), Validators.maxLength(50)]),
    CreateFields.description: fb.control<String>('', [Validators.maxLength(500)]),
    CreateFields.type: fb.control<String>(typeDefault?.typeAsString ?? '', [Validators.required]),
    CreateFields.account: fb.control<String>(accountId ?? '', [Validators.required]),
    CreateFields.baseAmount: fb.control<String>('', CreateFields.baseAmountValidators),
    CreateFields.baseCurrency: fb.control<String>('', CreateFields.baseCurrencyValidators),
    CreateFields.exchangeRate: fb.control<String>('', CreateFields.exchangeRateValidators),
    CreateFields.targetAmount: fb.control<String>('', CreateFields.targetAmountValidators),
    CreateFields.targetCurrency: fb.control<String>('', CreateFields.targetCurrencyValidators),
  });
}

/// See [createTransactionForm]
@riverpod
class FundDetailsController extends _$FundDetailsController {
  @override
  ({FundDetailsFieldState fundDetailsFieldState, CurrencyState currencyState}) build(FormGroup form) {
    return (
      fundDetailsFieldState: FundDetailsFieldState.baseAndTarget,
      currencyState: form.value[CreateFields.type] == 'income' ? CurrencyState.income : CurrencyState.expense
    );
  }

  final Map<String, List<Validator<dynamic>>> _formValidators = {
    CreateFields.baseAmount: CreateFields.baseAmountValidators,
    CreateFields.targetAmount: CreateFields.targetAmountValidators,
    CreateFields.exchangeRate: CreateFields.exchangeRateValidators,
  };

  final List<String> _allFields = [
    CreateFields.baseAmount,
    CreateFields.targetAmount,
    CreateFields.exchangeRate,
  ];

  /// Sets the state of a form control.
  ///
  /// The state of the form control is determined by the [isFieldEnabled] parameter.
  /// If [isFieldEnabled] is true, the form control is enabled and its validators are set to [validators].
  /// If [isFieldEnabled] is false, the form control is disabled, its validators are cleared, and its value is set to null.
  ///
  /// [formControl] is the form control whose state is to be set.
  /// [isFieldEnabled] determines whether the form control should be enabled or disabled.
  /// [validators] is an optional parameter that specifies the validators for the form control. It is only used if [isFieldEnabled] is true.
  void _setFormControlState(
    AbstractControl<dynamic> formControl,
    bool isFieldEnabled, {
    List<Validator<dynamic>>? validators,
  }) {
    if (isFieldEnabled) {
      formControl
        ..setValidators(validators ?? [])
        ..markAsEnabled();
    } else {
      formControl
        ..markAsDisabled()
        ..setValidators([])
        ..value = null;
    }
  }

  /// Sets the form state and updates the fields.
  ///
  /// The form state is set to [fundDetailsFieldState].
  /// Each field in [_allFields] is updated based on whether its name is in [enabledFields].
  /// If a field's name is in [enabledFields], the field is enabled and its validators are set.
  /// If a field's name is not in [enabledFields], the field is disabled, its validators are cleared, and its value is set to null.
  ///
  /// [fundDetailsFieldState] is the form state to be set.
  /// [enabledFields] is a list of field names that should be enabled.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// void setForBaseAndTarget() {
  ///   _setForStateAndUpdateFields(
  ///     FormCurrencyExchangeState.baseAndTarget,
  ///     [
  ///       CreateFields.baseAmount,
  ///       CreateFields.targetAmount,
  ///     ],
  ///  );
  /// }
  /// ```
  void _setForStateAndUpdateFields(FundDetailsFieldState fundDetailsFieldState, List<String> enabledFields) {
    state = (fundDetailsFieldState: fundDetailsFieldState, currencyState: state.currencyState);
    print(state);

    for (final fieldName in _allFields) {
      _setFormControlState(form.control(fieldName), enabledFields.contains(fieldName),
          validators: _formValidators[fieldName]);
    }
  }

  void setForBaseAndTarget() {
    _setForStateAndUpdateFields(
      FundDetailsFieldState.baseAndTarget,
      [CreateFields.baseAmount, CreateFields.targetAmount],
    );
  }

  void setForBaseAndExchange() {
    _setForStateAndUpdateFields(
      FundDetailsFieldState.baseAndExchange,
      [CreateFields.baseAmount, CreateFields.exchangeRate],
    );
  }

  void setForTargetAndExchange() {
    _setForStateAndUpdateFields(
      FundDetailsFieldState.targetAndExchange,
      [CreateFields.targetAmount, CreateFields.exchangeRate],
    );
  }

  /// This method validates the given fields.
  bool _validateFields(List<String> fieldNames) {
    for (final fieldName in fieldNames) {
      if (!form.control(fieldName).valid) {
        return false;
      }
    }
    return true;
  }

  /// This helper method calculates a value by performing a certain operation at the values of two fields.
  double _calculateField(String field1, String field2, double Function(double, double) operation) {
    final value1 = double.parse(form.control(field1).value as String);
    final value2 = double.parse(form.control(field2).value as String);

    return operation(value1, value2);
  }

  void onAnyFieldChanged() {
    print('state on change: $state');
    switch (state.fundDetailsFieldState) {
      case FundDetailsFieldState.baseAndTarget:
        if (!_validateFields([CreateFields.baseAmount, CreateFields.targetAmount])) {
          return;
        }
        final exchangeRate = _calculateField(CreateFields.baseAmount, CreateFields.targetAmount,
            (baseAmount, targetAmount) => baseAmount / targetAmount);
        form.control(CreateFields.exchangeRate).value = exchangeRate.toStringAsFixed(5);
        form.control(CreateFields.exchangeRate).markAsTouched();

      case FundDetailsFieldState.baseAndExchange:
        if (!_validateFields([CreateFields.baseAmount, CreateFields.exchangeRate])) {
          return;
        }
        final targetAmount = _calculateField(CreateFields.baseAmount, CreateFields.exchangeRate,
            (baseAmount, exchangeRate) => baseAmount * exchangeRate);
        form.control(CreateFields.targetAmount).value = targetAmount.toStringAsFixed(2);
        form.control(CreateFields.exchangeRate).markAsTouched();

      case FundDetailsFieldState.targetAndExchange:
        if (!_validateFields([CreateFields.targetAmount, CreateFields.exchangeRate])) {
          return;
        }
        final baseAmount = _calculateField(CreateFields.targetAmount, CreateFields.exchangeRate,
            (targetAmount, exchangeRate) => targetAmount / exchangeRate);
        form.control(CreateFields.baseAmount).value = baseAmount.toStringAsFixed(2);
        form.control(CreateFields.exchangeRate).markAsTouched();

      case FundDetailsFieldState.notSet:
        // Handle notSet case
        break;
    }
  }

  void disableCurrencyExchange() {
    _setFormControlState(form.control(CreateFields.exchangeRate), false);
    _setFormControlState(form.control(CreateFields.targetAmount), false);
    _setFormControlState(form.control(CreateFields.baseAmount), true,
        validators: CreateFields.baseAmountValidators);
  }
}
