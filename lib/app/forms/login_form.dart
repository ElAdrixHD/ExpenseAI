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
          "login.email",
          label: trans('login_page.email_placeholder'),
          style: 'default',
          validate:
              FormValidator.rule("email", message: trans('errors.email_form')),
        ),
        Field.password(
          "login.password",
          viewable: true,
          label: trans('login_page.password_placeholder'),
          style: 'default',
          validate:
              FormValidator.notEmpty(message: trans('errors.password_form')),
        ),
      ];
}
