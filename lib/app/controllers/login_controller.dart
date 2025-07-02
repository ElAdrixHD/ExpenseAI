import 'package:nylo_framework/nylo_framework.dart';

import '/app/events/login_event.dart';
import '/app/networking/firebase_service.dart';
import '/app/networking/analytics_service.dart';
import 'controller.dart';

class ForgotPasswordException implements Exception {
  final String message;
  final bool isWarning;
  
  ForgotPasswordException(this.message, {this.isWarning = false});
}

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
      throw ForgotPasswordException(trans('login_page.email_required'), isWarning: true);
    }
    
    if (!_isValidEmail(email)) {
      throw Exception(trans('errors.firebase_auth.invalid_email'));
    }
    
    await FirebaseAuthService.resetPassword(email: email);
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}
