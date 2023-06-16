import 'package:reactive_forms/reactive_forms.dart';

final loginForm = FormGroup({
  'email': FormControl<String>(
    value: 'harrislinux@gmail.com',
    validators: [
      Validators.required,
      Validators.email,
    ],
  ),
  'password': FormControl<String>(
    value: 'harris',
    validators: [
      Validators.required,
    ],
  ),
});

final registerForm = FormGroup(
  {
    'email': FormControl<String>(
      // value: 'admin@admin.admin',
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'username': FormControl<String>(
      // value: 'admin',
      validators: [
        Validators.required,
        Validators.minLength(5),
      ],
    ),
    'password': FormControl<String>(
      // value: 'admin',
      validators: [
        Validators.required,
        Validators.minLength(6),
      ],
    ),
    'confirmPassword': FormControl<String>(
      // value: 'admin',
      validators: [
        Validators.required,
      ],
    ),
  },
  validators: [
    Validators.mustMatch('password', 'confirmPassword'),
  ],
);
