import 'package:firebase_core/firebase_core.dart';
import 'package:nylo_framework/nylo_framework.dart';

class FirebaseProvider implements NyProvider {
  @override
  boot(Nylo nylo) async {
    await Firebase.initializeApp();
    return nylo;
  }

  @override
  afterBoot(Nylo nylo) async {}
}
