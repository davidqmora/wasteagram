import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';

class Analytics {
  static Analytics _instance;

  final FirebaseAnalytics _firebase;

  Analytics._() : this._firebase = FirebaseAnalytics();

  factory Analytics() {
    if (_instance == null) {
      _instance = Analytics._();
    }

    return _instance;
  }

  NavigatorObserver getNavigatorObserver() =>
      FirebaseAnalyticsObserver(analytics: _firebase);

  void setScreenName(String name) {
    _firebase.setCurrentScreen(screenName: name);
  }

  void saveEvent(String eventName, Map<String, dynamic> params) {
    _firebase.logEvent(name: eventName, parameters: params);
  }
}
