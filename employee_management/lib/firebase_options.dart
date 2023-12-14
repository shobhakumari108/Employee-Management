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
        return macos;
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
    apiKey: 'AIzaSyCZZI1Or6oNcK_bnzu5chWzOXLDDCrqAYw',
    appId: '1:773435849487:web:09d93ea458ac11db451c7a',
    messagingSenderId: '773435849487',
    projectId: 'employee-management-aac90',
    authDomain: 'employee-management-aac90.firebaseapp.com',
    storageBucket: 'employee-management-aac90.appspot.com',
    measurementId: 'G-YYR70C6L9S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeRiMpgoC70EbLt5wvjlPHnMfLofZG7sg',
    appId: '1:773435849487:android:21a7babf2d4c19e4451c7a',
    messagingSenderId: '773435849487',
    projectId: 'employee-management-aac90',
    storageBucket: 'employee-management-aac90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcB7EQvhVxDKKXyeIK58DHzm8UCcStJS8',
    appId: '1:773435849487:ios:a9d819897e629c55451c7a',
    messagingSenderId: '773435849487',
    projectId: 'employee-management-aac90',
    storageBucket: 'employee-management-aac90.appspot.com',
    iosBundleId: 'com.example.employeeManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcB7EQvhVxDKKXyeIK58DHzm8UCcStJS8',
    appId: '1:773435849487:ios:4a8df6fc8f7ecb39451c7a',
    messagingSenderId: '773435849487',
    projectId: 'employee-management-aac90',
    storageBucket: 'employee-management-aac90.appspot.com',
    iosBundleId: 'com.example.employeeManagement.RunnerTests',
  );
}
