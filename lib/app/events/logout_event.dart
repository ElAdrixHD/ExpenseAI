import 'package:nylo_framework/nylo_framework.dart';

import '../networking/firebase_service.dart';
import '../networking/analytics_service.dart';

class LogoutEvent implements NyEvent {
  @override
  final listeners = {
    DefaultListener: DefaultListener(),
  };
}

class DefaultListener extends NyListener {
  @override
  handle(dynamic event) async {
    // Track logout event
    await AnalyticsService.trackLogout();
    
    await Future.wait([
      FirebaseAuthService.signOut(),
      Auth.logout(),
    ]);

    routeToInitial();
  }
}
