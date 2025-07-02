import 'package:expense_agent/resources/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/login_controller.dart';
import '/app/forms/login_form.dart';
import '/app/networking/analytics_service.dart';
import '/bootstrap/extensions.dart';
import '/config/design.dart';
import '/resources/widgets/buttons/buttons.dart';

class LoginPage extends NyStatefulWidget<LoginController> {
  static RouteView path = ("/login", (_) => LoginPage());

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyPage<LoginPage> {
  final form = LoginForm();
  @override
  get init => () {
        AnalyticsService.trackScreenView(screenName: 'login_page');
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
                        width: double.infinity,
                        submitForm: (
                          form,
                          (data) async {
                            try {
                              await widget.controller.handleLogin(data);
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
                          routeTo(RegisterPage.path);
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
                          // Track forgot password interaction
                          await AnalyticsService.trackEvent(
                            name: 'forgot_password_clicked',
                            parameters: {
                              'screen': 'login_page',
                              'timestamp':
                                  DateTime.now().millisecondsSinceEpoch,
                            },
                          );

                          try {
                            String? email = form.data(key: 'login.email');
                            await widget.controller.handleForgotPassword(email);
                            showToastSuccess(
                              title: trans(
                                  'login_page.toast_success_forgot_password_title'),
                              description: trans(
                                  'login_page.toast_success_forgot_password_description'),
                            );
                            
                            // Track successful forgot password
                            await AnalyticsService.trackEvent(
                              name: 'forgot_password_success',
                              parameters: {
                                'screen': 'login_page',
                                'timestamp': DateTime.now().millisecondsSinceEpoch,
                              },
                            );
                          } on ForgotPasswordException catch (e) {
                            if (e.isWarning) {
                              showToastWarning(
                                title: trans('login_page.toast_warning_title'),
                                description: e.message,
                              );
                            } else {
                              showToastDanger(
                                title: trans('errors.toast_title'),
                                description: e.message,
                              );
                            }
                          } on Exception catch (e) {
                            showToastDanger(
                              title: trans('errors.toast_title'),
                              description: e.message,
                            );
                            
                            // Track failed forgot password
                            await AnalyticsService.trackEvent(
                              name: 'forgot_password_failed',
                              parameters: {
                                'screen': 'login_page',
                                'error': e.message,
                                'timestamp': DateTime.now().millisecondsSinceEpoch,
                              },
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
