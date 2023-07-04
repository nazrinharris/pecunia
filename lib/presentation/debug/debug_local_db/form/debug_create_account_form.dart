import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_create_account_form.g.dart';

@riverpod
FormGroup createAccountForm(CreateAccountFormRef ref) => FormGroup({
      'name': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(1),
          Validators.maxLength(50),
        ],
      ),
      'description': FormControl<String>(
        validators: [
          Validators.maxLength(500),
        ],
      ),
      'currency': FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(3),
        ],
      ),
      'initialBalance': FormControl<String>(
        validators: [
          Validators.required,
          const CurrencyValidator(),
        ],
      ),
    });

class CurrencyValidator extends Validator<dynamic> {
  const CurrencyValidator() : super();

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
