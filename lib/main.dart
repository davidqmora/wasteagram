import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';

// Semantics code based on information gleaned from the documentation and
// from the following articles:
// https://kpsroka.dev/technical/guide-to-flutter-semantics.html
// https://medium.com/flutter-community/a-deep-dive-into-flutters-accessibility-widgets-eb0ef9455bc
//
// Crashlytics usage guidance taken from:
// https://medium.com/flutter-community/how-to-keep-track-of-bugs-by-integrating-firebase-crashlytics-in-flutter-app-6c406e346d4a

void main() {
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZonedGuarded<Future<void>>(() async {
    runApp(App());
  }, Crashlytics.instance.recordError);
}
