import 'package:nylo_framework/nylo_framework.dart';

/* Register Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/6.x/forms#how-it-works
| Casts: https://nylo.dev/docs/6.x/forms#form-casts
| Validation Rules: https://nylo.dev/docs/6.x/validation#validation-rules
|-------------------------------------------------------------------------- */

class RegisterForm extends NyFormData {
  RegisterForm({String? name}) : super(name ?? "register");

  @override
  List<Field> fields() => [
        Field.email(
          "register.email",
          style: 'default',
          label: trans('register_page.email_placeholder'),
          validate: FormValidator.email(message: trans('errors.email_form')),
        ),
        Field.password(
          "register.password",
          viewable: true,
          style: 'default',
          label: trans('register_page.password_placeholder'),
          validate: FormValidator.notEmpty(
            message: trans('errors.password_required'),
          ),
        ),
        Field.password(
          "register.confirm_password",
          viewable: true,
          style: 'default',
          label: trans('register_page.confirm_password_placeholder'),
          validate: FormValidator.custom(
            (value) {
              Map formData = data();
              dynamic password = formData['register.password'] ?? "";
              return password == value;
            },
            message: trans('errors.passwords_do_not_match'),
          ),
        ),
      ];
}
