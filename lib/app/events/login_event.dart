import 'package:nylo_framework/nylo_framework.dart';

import '/app/networking/firebase_service.dart';
import '/resources/pages/home_page.dart';

class LoginEvent implements NyEvent {
  @override
  final listeners = {
    LoginListener: LoginListener(),
  };
}

class LoginListener extends NyListener {
  @override
  handle(dynamic event) async {
    if (event == null || event is! Map) return;
    
    String email = event['email'] ?? '';
    String password = event['password'] ?? '';
    
    final user = await FirebaseAuthService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (user != null) {
      await Auth.authenticate(data: user.toJson());
      routeTo(HomePage.path, navigationType: NavigationType.pushAndForgetAll);
    }
  }
}