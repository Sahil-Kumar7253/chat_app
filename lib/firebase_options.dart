// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAL4hPJzeZaVW_-dKWNPAlwV7EcrIBhAMI',
    appId: '1:990086000481:web:3175482bf9c399e9365f20',
    messagingSenderId: '990086000481',
    projectId: 'chat-app-94e07',
    authDomain: 'chat-app-94e07.firebaseapp.com',
    storageBucket: 'chat-app-94e07.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWagbKAAs2-lZF3LL47orufYXIcxIrVSU',
    appId: '1:990086000481:android:77156f4e1f27882c365f20',
    messagingSenderId: '990086000481',
    projectId: 'chat-app-94e07',
    storageBucket: 'chat-app-94e07.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCw-Pam5U4ARJRXOOxwYN9XKgvBy-zT40',
    appId: '1:990086000481:ios:3f1cbc56bf351e59365f20',
    messagingSenderId: '990086000481',
    projectId: 'chat-app-94e07',
    storageBucket: 'chat-app-94e07.firebasestorage.app',
    iosBundleId: 'com.example.chatApp1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCCw-Pam5U4ARJRXOOxwYN9XKgvBy-zT40',
    appId: '1:990086000481:ios:3f1cbc56bf351e59365f20',
    messagingSenderId: '990086000481',
    projectId: 'chat-app-94e07',
    storageBucket: 'chat-app-94e07.firebasestorage.app',
    iosBundleId: 'com.example.chatApp1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAL4hPJzeZaVW_-dKWNPAlwV7EcrIBhAMI',
    appId: '1:990086000481:web:dc4bf5561b203215365f20',
    messagingSenderId: '990086000481',
    projectId: 'chat-app-94e07',
    authDomain: 'chat-app-94e07.firebaseapp.com',
    storageBucket: 'chat-app-94e07.firebasestorage.app',
  );
}
