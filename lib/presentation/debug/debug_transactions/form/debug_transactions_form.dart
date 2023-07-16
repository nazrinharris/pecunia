import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/edit_account/debug_edit_account_providers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_transactions_form.g.dart';

enum FundDetailsFieldState {
  baseAndTarget,
  baseAndExchange,
  targetAndExchange,
  notSet,
}

class CreateFields {
  static const name = 'name';
  static const description = 'description';
  static const type = 'type';
  static const account = 'account';
  static const baseAmount = 'baseAmount';
  static const baseCurrency = 'baseCurrency';
  static const exchangeRate = 'exchangeRate';
  static const targetAmount = 'targetAmount';
  static const targetCurrency = 'targetCurrency';

  static final baseAmountValidators = [
    Validators.required,
    const CurrencyNumberValidator(),
  ];

  static final exchangeRateValidators = [
    const DoubleValidator(),
  ];

  static final targetAmountValidators = [
    Validators.required,
    const CurrencyNumberValidator(),
  ];
}

@riverpod
FormGroup createTransactionForm(CreateTransactionFormRef ref, {String? typeDefault, String? accountId}) =>
    FormGroup({
      CreateFields.name: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(1),
          Validators.maxLength(50),
        ],
      ),
      CreateFields.description: FormControl<String>(
        validators: [
          Validators.maxLength(500),
        ],
      ),
      CreateFields.type: FormControl<String>(
        value: typeDefault,
        validators: [
          Validators.required,
        ],
      ),
      CreateFields.account: FormControl<String>(
        value: accountId,
        validators: [
          Validators.required,
        ],
      ),
      CreateFields.baseAmount: FormControl<String>(
        validators: CreateFields.baseAmountValidators,
      ),
      CreateFields.baseCurrency: FormControl<String>(
        validators: [
          Validators.minLength(3),
          Validators.maxLength(3),
        ],
      ),
      CreateFields.exchangeRate: FormControl<String>(
        validators: CreateFields.exchangeRateValidators,
      ),
      CreateFields.targetAmount: FormControl<String>(
        validators: CreateFields.targetAmountValidators,
      ),
      CreateFields.targetCurrency: FormControl<String>(
        validators: [
          Validators.minLength(3),
          Validators.maxLength(3),
        ],
      ),
    });

@riverpod
FormGroup editTransactionForm(
  EditTransactionFormRef ref,
  Transaction txn,
  Account account,
) =>
    FormGroup({
      'txnName': FormControl<String>(
        value: txn.name,
        validators: [
          Validators.required,
          Validators.minLength(1),
          Validators.maxLength(50),
        ],
      ),
      'description': FormControl<String>(
        value: txn.transactionDescription.value,
        validators: [
          Validators.maxLength(500),
        ],
      ),
      'type': FormControl<String>(
        value: txn.fundDetails.transactionType.typeAsString,
        validators: [
          Validators.required,
        ],
      ),
      'account': FormControl<String>(
        value: account.id,
        validators: [
          Validators.required,
        ],
      ),
      'amount': FormControl<String>(
        value: txn.fundDetails.transactionAmount.toString(),
        validators: [
          Validators.required,
          const CurrencyNumberValidator(),
        ],
      ),
    });
