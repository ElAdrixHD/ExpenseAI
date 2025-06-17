import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/register_controller.dart';
import '/app/forms/register_form.dart';
import '/app/networking/analytics_service.dart';
import '/bootstrap/extensions.dart';
import '/config/design.dart';
import '/resources/widgets/buttons/buttons.dart';

class RegisterPage extends NyStatefulWidget<RegisterController> {
  static RouteView path = ("/register", (_) => RegisterPage());

  RegisterPage({super.key}) : super(child: () => _RegisterPageState());
}

class _RegisterPageState extends NyPage<RegisterPage> {
  final form = RegisterForm();

  @override
  get init => () {
        AnalyticsService.trackScreenView(screenName: 'register_page');
      };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100, width: 100, child: logo),
                SizedBox(height: 30),
                Text(
                  trans('register_page.welcome_message'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.color.content,
                  ),
                ),
                SizedBox(height: 40),
                NyForm(
                  form: form,
                  crossAxisSpacing: 16,
                  footerSpacing: 24,
                  loadingStyle: LoadingStyle.normal(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  footer: Column(
                    children: [
                      Button.primary(
                        text: trans("register_page.register_button_text"),
                        width: double.infinity,
                        submitForm: (
                          form,
                          (data) async {
                            try {
                              await widget.controller.handleRegister(data);
                            } on Exception catch (e) {
                              showToastDanger(
                                title: trans('errors.toast_title'),
                                description: e.message,
                              );
                            }
                          }
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              trans('register_page.login_text'),
                              style: TextStyle(
                                color: context.color.content
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            Text(
                              trans('register_page.login_button_text'),
                              style: TextStyle(
                                color: context.color.primaryAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
