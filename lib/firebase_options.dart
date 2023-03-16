// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0m41UYILAR-ophVtpA7PwUsbpWPhpULc',
    appId: '1:210094941641:web:e53c14dc639d40e1e63418',
    messagingSenderId: '210094941641',
    projectId: 'social-app-61ae5',
    authDomain: 'social-app-61ae5.firebaseapp.com',
    storageBucket: 'social-app-61ae5.appspot.com',
    measurementId: 'G-M17FELTB9X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3naAJyfN2sPwAvPPrxZHzLmUDCp90qdQ',
    appId: '1:210094941641:android:acb7d602dff60edbe63418',
    messagingSenderId: '210094941641',
    projectId: 'social-app-61ae5',
    storageBucket: 'social-app-61ae5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2ZcgkJGhlnTo-t1HV1ksKtHTKXvk6Gxk',
    appId: '1:210094941641:ios:ea4d448e67d51a00e63418',
    messagingSenderId: '210094941641',
    projectId: 'social-app-61ae5',
    storageBucket: 'social-app-61ae5.appspot.com',
    iosClientId: '210094941641-pajhmaggm9s8m9je39791dcklmah3qsp.apps.googleusercontent.com',
    iosBundleId: 'com.example.chattyApp',
  );
}