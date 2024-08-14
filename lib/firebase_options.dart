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
    apiKey: 'AIzaSyDOxRy2Ts4rqVfXVS9PLeoJV0_8t6G8xlY',
    appId: '1:270248282518:web:9c1e633446df7964b9b5b7',
    messagingSenderId: '270248282518',
    projectId: 'digitalepisode-e3d2a',
    authDomain: 'digitalepisode-e3d2a.firebaseapp.com',
    storageBucket: 'digitalepisode-e3d2a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-78YEDAvacA0sSZuYtrfMot3trnhk8k0',
    appId: '1:270248282518:android:62d63cfd4d0a7d28b9b5b7',
    messagingSenderId: '270248282518',
    projectId: 'digitalepisode-e3d2a',
    storageBucket: 'digitalepisode-e3d2a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCy3duhTOjdQOjmvAr94RkiqqP-qEp5VAA',
    appId: '1:270248282518:ios:f5ba5e6aeb33ad38b9b5b7',
    messagingSenderId: '270248282518',
    projectId: 'digitalepisode-e3d2a',
    storageBucket: 'digitalepisode-e3d2a.appspot.com',
    iosBundleId: 'com.example.digitalEpisodeNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCy3duhTOjdQOjmvAr94RkiqqP-qEp5VAA',
    appId: '1:270248282518:ios:f5ba5e6aeb33ad38b9b5b7',
    messagingSenderId: '270248282518',
    projectId: 'digitalepisode-e3d2a',
    storageBucket: 'digitalepisode-e3d2a.appspot.com',
    iosBundleId: 'com.example.digitalEpisodeNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDOxRy2Ts4rqVfXVS9PLeoJV0_8t6G8xlY',
    appId: '1:270248282518:web:561caeb19b77e825b9b5b7',
    messagingSenderId: '270248282518',
    projectId: 'digitalepisode-e3d2a',
    authDomain: 'digitalepisode-e3d2a.firebaseapp.com',
    storageBucket: 'digitalepisode-e3d2a.appspot.com',
  );
}
