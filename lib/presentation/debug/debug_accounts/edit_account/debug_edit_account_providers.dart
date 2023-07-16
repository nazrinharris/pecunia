import 'package:fpdart/fpdart.dart';
import 'package:pecunia/features/accounts/domain/accounts_repo.dart';
import 'package:pecunia/features/accounts/domain/entities/account.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_edit_account_providers.g.dart';

@riverpod
class EditAccount extends _$EditAccount {
  @override
  Future<Option<Unit>> build() async {
    return const Option.none();
  }

  Future<void> editAccount({
    required Account oldAccount,
    required String name,
    required double initialBalance,
    required String currency,
    String? description,
  }) async {
    state = const AsyncValue.loading();

    final newAccount = oldAccount.copyWith(
      name: name,
      initialBalance: initialBalance,
      currency: currency,
      description: AccountDescription(description),
    );

    (await ref.watch(accountsRepoProvider).updateAccountDetails(newAccount).run()).fold(
      (l) => state = AsyncError(l, l.stackTrace),
      (r) => state = AsyncData(Option.of(r)),
    );
  }
}

@riverpod
FormGroup editAccountForm(
  EditAccountFormRef ref, {
  required String name,
  required String currency,
  required String initialBalance,
  String? description,
}) =>
    FormGroup({
      'name': FormControl<String>(
        value: name,
        validators: [
          Validators.required,
          Validators.minLength(1),
          Validators.maxLength(50),
        ],
      ),
      'description': FormControl<String>(
        value: description,
        validators: [
          Validators.maxLength(500),
        ],
      ),
      'currency': FormControl<String>(
        value: currency,
        validators: [
          Validators.required,
          Validators.maxLength(3),
        ],
      ),
      'initialBalance': FormControl<String>(
        value: initialBalance,
        validators: [
          Validators.required,
          const CurrencyNumberValidator(),
        ],
      ),
    });

class CurrencyNumberValidator extends Validator<dynamic> {
  const CurrencyNumberValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final regex = RegExp(r'^\d{0,12}(\.\d{1,2})?$');
    return control.isNotNull &&
            control.value != null &&
            regex.hasMatch(control.value.toString()) &&
            double.tryParse(control.value.toString()) != null &&
            double.parse(control.value.toString()) >= 0
        ? null
        : {'currency': true};
  }
}

class DoubleValidator extends Validator<dynamic> {
  const DoubleValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final value = control.value;
    // Check for null, empty, or blank string.
    if (value == null || value.toString().isEmpty || value.toString().trim() == '') {
      return {'double': true};
    }

    // Try parsing the value to a double.
    final doubleValue = double.tryParse(value.toString());

    // If it can't be parsed to a double, return error.
    if (doubleValue == null) {
      return {'double': true};
    }

    // If everything checks out, return null (no error).
    return null;
  }
}
