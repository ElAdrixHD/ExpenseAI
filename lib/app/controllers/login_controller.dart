import 'package:nylo_framework/nylo_framework.dart';

import '/app/events/login_event.dart';
import '/app/networking/firebase_service.dart';
import '/app/networking/analytics_service.dart';
import 'controller.dart';

class LoginController extends Controller {
  Future<void> handleLogin(Map<String, dynamic> data) async {
    String email = data['login.email'] ?? '';
    String password = data['login.password'] ?? '';

    if (email.isEmpty || password.isEmpty) {
      throw Exception(trans('login_page.invalid_form'));
    }
    
    try {
      await event<LoginEvent>(data: {'email': email, 'password': password});
      
      // Track successful login
      await AnalyticsService.trackLogin(method: 'email');
      await AnalyticsService.setUserId(email);
      await AnalyticsService.setUserProperty(name: 'login_method', value: 'email');
    } catch (e) {
      // Track failed login attempt
      await AnalyticsService.trackEvent(
        name: 'login_failed',
        parameters: {
          'method': 'email',
          'error': e.toString(),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      rethrow;
    }
  }

  Future<void> handleForgotPassword(String? email) async {
    if (email == null || email.isEmpty) {
      throw Exception(trans('login_page.email_required'));
    }
    await FirebaseAuthService.resetPassword(email: email);
  }
}
