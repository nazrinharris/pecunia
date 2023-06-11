import 'package:reactive_forms/reactive_forms.dart';

final loginForm = FormGroup({
  'email': FormControl<String>(
    value: 'admin@admin.admin',
    validators: [
      Validators.required,
      Validators.email,
    ],
  ),
  'password': FormControl<String>(
    value: 'admin',
    validators: [
      Validators.required,
      Validators.minLength(5),
    ],
  ),
});
