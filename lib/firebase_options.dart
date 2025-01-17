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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMMXmPLqcjhng29fAOG-lVFId6CrGB_fk',
    appId: '1:995806483858:android:bf2141c36eaa45f75add4b',
    messagingSenderId: '995806483858',
    projectId: 'wholesalegrocery-e93ab',
    storageBucket: 'wholesalegrocery-e93ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOBG_Iun-7tGYDmgk5Zj-udaWLkJmrB74',
    appId: '1:995806483858:ios:ef67cad9ca5670785add4b',
    messagingSenderId: '995806483858',
    projectId: 'wholesalegrocery-e93ab',
    storageBucket: 'wholesalegrocery-e93ab.appspot.com',
    androidClientId: '995806483858-n15s61ht8gamemv0rrpqhvpmr0nqpp0j.apps.googleusercontent.com',
    iosClientId: '995806483858-2o91rq4husge4gd4ifcl9he6dh6rc4a2.apps.googleusercontent.com',
    iosBundleId: 'com.example.wholesaleAdmin',
  );
}
