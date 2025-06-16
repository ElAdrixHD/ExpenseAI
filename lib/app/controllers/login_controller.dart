import 'package:nylo_framework/nylo_framework.dart';

import '/app/events/login_event.dart';
import '/app/networking/firebase_service.dart';
import 'controller.dart';

class LoginController extends Controller {
  Future<void> handleLogin(Map<String, dynamic> data) async {
    String email = data['login.email'] ?? '';
    String password = data['login.password'] ?? '';

    if (email.isEmpty || password.isEmpty) {
      throw Exception(trans('login_page.invalid_form'));
    }
    
    await event<LoginEvent>(data: {'email': email, 'password': password});
  }

  Future<void> handleForgotPassword(String? email) async {
    if (email == null || email.isEmpty) {
      throw Exception(trans('login_page.email_required'));
    }
    await FirebaseAuthService.resetPassword(email: email);
  }
}
