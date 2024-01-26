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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC8TepaE5FcFLKHUVlHhP0FqL4mk5t8yB0',
    appId: '1:90321007074:web:6260a60ff2520d7fca09bb',
    messagingSenderId: '90321007074',
    projectId: 'dovlat-fdafd',
    authDomain: 'dovlat-fdafd.firebaseapp.com',
    storageBucket: 'dovlat-fdafd.appspot.com',
    measurementId: 'G-77VZYDY0C8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBirfhGpR0JelhJZYfRWkFv1w_lXEwvfMo',
    appId: '1:90321007074:android:bb91ad72d67e3e36ca09bb',
    messagingSenderId: '90321007074',
    projectId: 'dovlat-fdafd',
    storageBucket: 'dovlat-fdafd.appspot.com',
  );
}