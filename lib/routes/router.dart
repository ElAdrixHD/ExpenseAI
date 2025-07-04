import 'package:nylo_framework/nylo_framework.dart';

import '/resources/pages/home_page.dart';
import '/resources/pages/login_page.dart';
import '/resources/pages/not_found_page.dart';
import '/resources/pages/register_page.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
|
| * [Tip] Add authentication 🔑
| Run the below in the terminal to add authentication to your project.
| "dart run scaffold_ui:main auth"
|
| * [Tip] Add In-app Purchases 💳
| Run the below in the terminal to add In-app Purchases to your project.
| "dart run scaffold_ui:main iap"
|
| Learn more https://nylo.dev/docs/6.x/router
|-------------------------------------------------------------------------- */

NyRouter appRouter() => nyRoutes((router) {
      router.add(LoginPage.path).initialRoute();
      router.add(RegisterPage.path);
      router.add(HomePage.path).authenticatedRoute();
      // Add your routes here ...
      // router.add(NewPage.path, transitionType: TransitionType.fade());

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      // });
      router.add(NotFoundPage.path).unknownRoute();
    });
