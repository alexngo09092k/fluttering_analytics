import 'package:fluttering/fluttering.dart';
import 'package:fluttering_analytics/analytics/models/analytics_provider.dart';
import 'package:fluttering_analytics/base_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GoogleAnalytics extends BaseAnalytics {
  late FirebaseAnalytics analytics;
  late FirebaseAnalyticsObserver observer;

  @override
  Future<bool> initial() async {
    try {
      _isSupported = await CurrentPlatform.instance.isGmsAvailable;
      Debug.log('GoogleAnalytics is supported $_isSupported');
      analytics = FirebaseAnalytics.instance;
      observer = FirebaseAnalyticsObserver(analytics: analytics);
      return true;
    } catch (error) {
      Debug.log("GoogleAnalytics initial error $error");
    }
    return false;
  }

  bool _isSupported = CurrentPlatform.instance.isHuawei;

  @override
  bool get isSupported => _isSupported;

  @override
  AnalyticsProvider get provider => AnalyticsProvider.google;

  @override
  Future<void> sendEvent(
    String name,
    Map<String, dynamic> parameters,
  ) async {
    // Only strings and numbers (longs & doubles for android, ints and doubles for iOS) are supported for GA custom event parameters:
    // https://firebase.google.com/docs/reference/ios/firebaseanalytics/api/reference/Classes/FIRAnalytics#+logeventwithname:parameters:
    // https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#public-void-logevent-string-name,-bundle-params
    return analytics.logEvent(name: name, parameters: parameters as Map<String, Object>);
  }
}
