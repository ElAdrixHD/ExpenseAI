import 'package:firebase_auth/firebase_auth.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user
  static User? get currentUser => _auth.currentUser;

  /// Check if user is authenticated
  static bool get isAuthenticated => _auth.currentUser != null;

  /// Sign in with email and password
  static Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Auth.authenticate(data: {
        'uid': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'displayName': userCredential.user?.displayName,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Create user with email and password
  static Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Auth.authenticate(data: {
        'uid': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'displayName': userCredential.user?.displayName,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await Auth.logout();
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  /// Reset password
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Get user friendly error messages
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
}
