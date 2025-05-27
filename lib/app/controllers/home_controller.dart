import 'package:expense_agent/app/networking/firebase_service.dart';
import 'package:expense_agent/resources/pages/login_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';

class HomeController extends Controller {
  onTapDocumentation() async {
    await launchUrl(Uri.parse("https://nylo.dev/docs"));
  }

  onTapGithub() async {
    await launchUrl(Uri.parse("https://github.com/nylo-core/nylo"));
  }

  onTapChangeLog() async {
    await launchUrl(Uri.parse("https://github.com/nylo-core/nylo/releases"));
  }

  onTapYouTube() async {
    await launchUrl(Uri.parse("https://m.youtube.com/@nylo_dev"));
  }

  onTapX() async {
    await launchUrl(Uri.parse("https://x.com/nylo_dev"));
  }

  signOut() async {
    await FirebaseAuthService.signOut();
    routeTo(LoginPage.path, navigationType: NavigationType.pushAndForgetAll);
  }
}
