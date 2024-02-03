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
    apiKey: 'AIzaSyDxY8KP3zC1czCWOD7EOpT5ZbqvJ81ef1o',
    appId: '1:520112955766:web:34f6c6e8894e04e61e1a57',
    messagingSenderId: '520112955766',
    projectId: 'mozz-abf42',
    authDomain: 'mozz-abf42.firebaseapp.com',
    storageBucket: 'mozz-abf42.appspot.com',
    measurementId: 'G-CK2130ZVQ2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBl0zrkLIQQV1KVYtqOifsb7K9zMtabk1Q',
    appId: '1:520112955766:android:07ac102cf12ceeba1e1a57',
    messagingSenderId: '520112955766',
    projectId: 'mozz-abf42',
    storageBucket: 'mozz-abf42.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjz9ACp4baWNyRwlbfe1DS4JZDgJwsebU',
    appId: '1:520112955766:ios:bf1ad33db68e07fe1e1a57',
    messagingSenderId: '520112955766',
    projectId: 'mozz-abf42',
    storageBucket: 'mozz-abf42.appspot.com',
    iosBundleId: 'com.example.mozzChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjz9ACp4baWNyRwlbfe1DS4JZDgJwsebU',
    appId: '1:520112955766:ios:fee682cd8db91ef01e1a57',
    messagingSenderId: '520112955766',
    projectId: 'mozz-abf42',
    storageBucket: 'mozz-abf42.appspot.com',
    iosBundleId: 'com.example.mozzChat.RunnerTests',
  );
}
