import 'package:expense_agent/app/providers/firebase_provider.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/providers/app_provider.dart';
import '/app/providers/event_provider.dart';
import '/app/providers/push_notifications_provider.dart';
import '/app/providers/route_provider.dart';

/* Providers
|--------------------------------------------------------------------------
| Add your "app/providers" here.
| Providers are booted when your application start.
|
| Learn more: https://nylo.dev/docs/6.x/providers
|-------------------------------------------------------------------------- */

final Map<Type, NyProvider> providers = {
  AppProvider: AppProvider(),
  FirebaseProvider: FirebaseProvider(),
  RouteProvider: RouteProvider(),
  EventProvider: EventProvider(),
  PushNotificationsProvider: PushNotificationsProvider(),
};
