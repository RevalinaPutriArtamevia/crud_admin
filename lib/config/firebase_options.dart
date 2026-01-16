import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "API_KEY",
      appId: "APP_ID",
      messagingSenderId: "SENDER_ID",
      projectId: "PROJECT_ID",
    );
  }
}
