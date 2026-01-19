import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }


  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyClwHxg1poPz-CBOtOmcRJBAao7NU3eJsY', 
    authDomain: 'lokal-food-02032003.firebaseapp.com',
    projectId: 'lokal-food-02032003',
    storageBucket: 'lokal-food-02032003.firebasestorage.app',
    messagingSenderId: '300727261141',
    appId: '1:300727261141:web:ff461d78a7c48030810f5c',
    measurementId: 'G-N2T69237K4',
  );


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQ8kX2QAOxoTROyvxH2kaewNO2ypIo_rg', 
    appId: '1:300727261141:android:05178731017f7de4810f5c', 
    messagingSenderId: '300727261141', 
    projectId: 'lokal-food-02032003', 
    storageBucket: 'lokal-food-02032003.firebasestorage.app', 
  );

  
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'ISI_API_KEY_IOS_ANDA',
    appId: 'ISI_APP_ID_IOS_ANDA',
    messagingSenderId: 'ISI_SENDER_ID_ANDA',
    projectId: 'nama-project-anda',
    storageBucket: 'nama-project-anda.appspot.com',
    iosBundleId: 'com.example.foodLokal',
  );
}