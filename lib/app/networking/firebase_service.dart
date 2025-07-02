import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:nylo_framework/nylo_framework.dart';

import '/app/models/user.dart';

class FirebaseAuthService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final Map<String, DateTime> _lastAttempts = {};
  static const Duration _rateLimitDuration = Duration(seconds: 30);
  static const int _maxAttempts = 5;

  static User? get currentUser => User(
        id: _auth.currentUser?.uid,
        name: _auth.currentUser?.displayName,
        email: _auth.currentUser?.email,
      );

  static bool get isAuthenticated => _auth.currentUser != null;

  static Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _checkRateLimit(email);
    
    try {
      auth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      _clearFailedAttempts(email);
      return User(
        id: userCredential.user?.uid,
        name: userCredential.user?.displayName,
        email: userCredential.user?.email,
      );
    } on auth.FirebaseAuthException catch (e) {
      _recordFailedAttempt(email);
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      _recordFailedAttempt(email);
      throw Exception('Authentication failed. Please try again.');
    }
  }

  static Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _checkRateLimit(email);
    
    try {
      auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      _clearFailedAttempts(email);
      return User(
        id: userCredential.user?.uid,
        email: userCredential.user?.email,
        name: userCredential.user?.displayName,
      );
    } on auth.FirebaseAuthException catch (e) {
      _recordFailedAttempt(email);
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      _recordFailedAttempt(email);
      throw Exception('Registration failed. Please try again.');
    }
  }

  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await Auth.logout();
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim().toLowerCase());
    } on auth.FirebaseAuthException catch (e) {
      String errorMessage = _getPasswordResetErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(trans('errors.firebase_auth.password_reset_generic'));
    }
  }

  static void _checkRateLimit(String email) {
    final key = email.toLowerCase();
    final lastAttempt = _lastAttempts[key];
    
    if (lastAttempt != null && 
        DateTime.now().difference(lastAttempt) < _rateLimitDuration) {
      throw Exception('Too many attempts. Please wait before trying again.');
    }
  }
  
  static void _recordFailedAttempt(String email) {
    final key = email.toLowerCase();
    _lastAttempts[key] = DateTime.now();
  }
  
  static void _clearFailedAttempts(String email) {
    final key = email.toLowerCase();
    _lastAttempts.remove(key);
  }

  static String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return trans('errors.firebase_auth.not_found');
      case 'wrong-password':
        return trans('errors.firebase_auth.wrong_password');
      case 'email-already-in-use':
        return trans('errors.firebase_auth.email_already_in_use');
      case 'weak-password':
        return trans('errors.firebase_auth.weak_password');
      case 'invalid-email':
        return trans('errors.firebase_auth.invalid_email');
      case 'user-disabled':
        return trans('errors.firebase_auth.user_disabled');
      case 'too-many-requests':
        return trans('errors.firebase_auth.too_many_requests');
      case 'operation-not-allowed':
        return trans('errors.firebase_auth.operation_not_allowed');
      case 'invalid-credential':
        return trans('errors.firebase_auth.invalid-credential');
      default:
        return trans('errors.firebase_auth.default');
    }
  }

  static String _getPasswordResetErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return trans('errors.firebase_auth.password_reset_user_not_found');
      case 'invalid-email':
        return trans('errors.firebase_auth.password_reset_invalid_email');
      case 'too-many-requests':
        return trans('errors.firebase_auth.password_reset_too_many_requests');
      case 'user-disabled':
        return trans('errors.firebase_auth.password_reset_user_disabled');
      default:
        return trans('errors.firebase_auth.password_reset_default');
    }
  }
}
