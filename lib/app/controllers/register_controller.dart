import '/app/controllers/controller.dart';
import 'package:nylo_framework/nylo_framework.dart';

class RegisterController extends Controller {
  handleRegister(Map<String, dynamic> data) async {
    String password = data['register.password'] ?? '';
    String confirmPassword = data['register.confirm_password'] ?? '';
    
    // Validate password strength
    String? passwordError = _validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }
    
    // Validate passwords match
    if (password != confirmPassword) {
      throw Exception(trans('errors.passwords_do_not_match'));
    }
    
    // TODO: Implement registration logic with Firebase
    print('Register data: $data');
  }
  
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return trans('errors.password_required');
    }
    if (password.length < 8) {
      return trans('errors.password_min_length');
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return trans('errors.password_weak');
    }
    return null;
  }
}
