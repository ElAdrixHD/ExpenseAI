import 'package:nylo_framework/nylo_framework.dart';

import '/app/networking/firebase_service.dart';
import '/resources/pages/home_page.dart';
import 'controller.dart';

class LoginController extends Controller {
  /// Handle login form submission
  Future<void> handleLogin(Map<String, dynamic> data) async {
    try {
      String email = data['login.email'] ?? '';
      String password = data['login.password'] ?? '';

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Please fill in all fields');
      }
      await FirebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      routeTo(HomePage.path, navigationType: NavigationType.pushAndForgetAll);
    } catch (e) {
      showToastDanger(
        title: "Error",
        description: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> handleForgotPassword(String email) async {
    try {
      if (email.isEmpty) {
        throw Exception('Please enter your email address');
      }

      await FirebaseAuthService.resetPassword(email: email);

      showToastSuccess(
        title: "Password Reset",
        description: "Password reset email sent. Check your inbox.",
      );
    } catch (e) {
      showToastDanger(
        title: "Error",
        description: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
