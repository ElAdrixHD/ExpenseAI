import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/controller.dart';
import '/app/events/register_event.dart';
import '/app/networking/analytics_service.dart';

class RegisterController extends Controller {
  Future handleRegister(Map<String, dynamic> data) async {
    // Sanitize and validate inputs
    String email = _sanitizeEmail(data['register.email'] ?? '');
    String password = data['register.password'] ?? '';
    String confirmPassword = data['register.confirm_password'] ?? '';

    // Validate email format
    if (email.isEmpty || !_isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    // Validate password strength
    String? passwordError = _validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }

    // Validate passwords match
    if (password != confirmPassword) {
      throw Exception(trans('errors.passwords_do_not_match'));
    }

    try {
      await event<RegisterEvent>(data: {'email': email, 'password': password});

      // Track successful registration
      await AnalyticsService.trackEvent(
        name: 'sign_up',
        parameters: {
          'method': 'email',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      await AnalyticsService.setUserId(email);
      await AnalyticsService.setUserProperty(
          name: 'registration_method', value: 'email');
    } catch (e) {
      // Track failed registration attempt
      await AnalyticsService.trackEvent(
        name: 'sign_up_failed',
        parameters: {
          'method': 'email',
          'error': e.toString(),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      rethrow;
    }
  }

  String _sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return trans('errors.password_required');
    }
    if (password.length < 8) {
      return trans('errors.password_min_length');
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]')
        .hasMatch(password)) {
      return 'Password must include uppercase, lowercase, number and special character';
    }
    return null;
  }
}
