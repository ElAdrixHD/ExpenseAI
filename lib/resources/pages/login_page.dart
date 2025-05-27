import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/login_controller.dart';
import '/app/forms/login_form.dart';
import '/bootstrap/extensions.dart';
import '../../config/design.dart';
import '../widgets/buttons/buttons.dart';

class LoginPage extends NyStatefulWidget<LoginController> {
  static RouteView path = ("/login", (_) => LoginPage());

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyPage<LoginPage> {
  final form = LoginForm();
  @override
  get init => () {};

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
                  trans('login_page.welcome_message'),
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
                        text: trans("login_page.login_button_text"),
                        showToastError: true,
                        width: double.infinity,
                        submitForm: (
                          form,
                          (data) async {
                            await widget.controller.handleLogin(data);
                          }
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          await changeLanguage('en');
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              trans('login_page.sign_up_text'),
                              style: TextStyle(
                                color: context.color.content
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            Text(
                              trans('login_page.sign_up_button_text'),
                              style: TextStyle(
                                color: context.color.primaryAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          String? email = form.data(key: 'login.email');
                          if (email != null && email.isNotEmpty) {
                            await widget.controller.handleForgotPassword(email);
                          } else {
                            showToastWarning(
                              title: "Email Required",
                              description: "Please enter your email first",
                            );
                          }
                        },
                        child: Text(
                          trans('login_page.forgot_password_text'),
                          style: TextStyle(
                            color: context.color.primaryAccent,
                          ),
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
