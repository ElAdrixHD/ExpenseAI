import 'package:nylo_framework/nylo_framework.dart';

import '/app/events/logout_event.dart';
import '/app/events/login_event.dart';
import '/app/events/register_event.dart';

/* Events
|--------------------------------------------------------------------------
| Add your "app/events" here.
| Events can be fired using: event<MyEvent>();
|
| Learn more: https://nylo.dev/docs/6.x/events
|-------------------------------------------------------------------------- */

final Map<Type, NyEvent> events = {
  LogoutEvent: LogoutEvent(),
  LoginEvent: LoginEvent(),
  RegisterEvent: RegisterEvent(),
};
