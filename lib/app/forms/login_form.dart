import 'package:nylo_framework/nylo_framework.dart';

/* Login Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/6.x/forms#how-it-works
| Casts: https://nylo.dev/docs/6.x/forms#form-casts
| Validation Rules: https://nylo.dev/docs/6.x/validation#validation-rules
|-------------------------------------------------------------------------- */

class LoginForm extends NyFormData {
  LoginForm({String? name}) : super(name ?? "login");

  @override
  List<Field> fields() => [
        Field.email(
          "Email",
          label: trans('login.email_placeholder'),
          validate: FormValidator.rule("email", message: trans('errors.email')),
        ),
        Field.password(
          "Password",
          label: trans('login.password_placeholder'),
          validate: FormValidator.password(
              strength: 2, message: trans('errors.password')),
        ),
      ];
}
