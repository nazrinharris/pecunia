import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:pecunia/features/transactions/domain/entities/transaction.dart';
import 'package:pecunia/presentation/debug/debug_accounts/edit_account/debug_edit_account_providers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_transactions_form.g.dart';

@riverpod
FormGroup createTransactionForm(CreateTransactionFormRef ref, {String? typeDefault, String? accountId}) =>
    FormGroup({
      'txnName': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(1),
        Validators.maxLength(50),
      ]),
      'description': FormControl<String>(validators: [
        Validators.maxLength(500),
      ]),
      'type': FormControl<String>(
        value: typeDefault,
        validators: [
          Validators.required,
        ],
      ),
      'account': FormControl<String>(
        value: accountId,
        validators: [
          Validators.required,
        ],
      ),
      'amount': FormControl<String>(validators: [
        Validators.required,
        const NumberValidator(),
      ]),
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
        value: txn.type.typeAsString,
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
          const NumberValidator(),
        ],
      ),
    });
