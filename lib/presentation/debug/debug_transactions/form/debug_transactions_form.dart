import 'package:pecunia/presentation/debug/debug_accounts/edit_account/debug_edit_account_providers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_transactions_form.g.dart';

@riverpod
FormGroup createTransactionForm(CreateTransactionFormRef ref) => FormGroup({
      'txnName': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(1),
        Validators.maxLength(50),
      ]),
      'description': FormControl<String>(validators: [
        Validators.maxLength(500),
      ]),
      'type': FormControl<String>(validators: [
        Validators.required,
      ]),
      'account': FormControl<String>(validators: [
        Validators.required,
      ]),
      'amount': FormControl<String>(validators: [
        Validators.required,
        const NumberValidator(),
      ]),
    });
