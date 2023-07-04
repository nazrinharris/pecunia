import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_form.g.dart';

@riverpod
FormGroup loginForm(LoginFormRef ref) => FormGroup({
      'email': FormControl<String>(
        value: 'harrislinux@gmail.com',
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        value: 'harrislinux',
        validators: [
          Validators.required,
        ],
      ),
    });

@riverpod
FormGroup registerForm(RegisterFormRef ref) => FormGroup(
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
