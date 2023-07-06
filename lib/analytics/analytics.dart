import 'dart:async';

import 'package:fluttering/fluttering.dart';
import 'package:fluttering_analytics/analytics/google/google_analytics.dart';
import 'package:fluttering_analytics/analytics/huawei/huawei_analytics.dart';
import 'package:fluttering_analytics/analytics/models/analytics_config.dart';
import 'package:fluttering_analytics/analytics/models/analytics_provider.dart';
import 'package:fluttering_analytics/base_analytics.dart';

abstract class IAwesomeAnalytics extends Provider
    with ProviderObserver, ProviderDelegate {
  AnalyticsConfig get config;

  void initial(AnalyticsConfig config);

  Future<void> sendEvent(String name, Map<String, dynamic> parameters);
}

class AwesomeAnalytics extends IAwesomeAnalytics {
  static final IAwesomeAnalytics _instance = AwesomeAnalytics._internal();
  static IAwesomeAnalytics get instance => _instance;

  factory AwesomeAnalytics() => _instance as AwesomeAnalytics;

  AwesomeAnalytics._internal();

  AnalyticsConfig _config = const AnalyticsConfig();
  @override
  AnalyticsConfig get config => _config;

  final Map<AnalyticsProvider, BaseAnalytics> _analytics = {};

  @override
  void initial(AnalyticsConfig config) async {
    _config = config;

    /// CHECKING ADS IS ENABLED
    if (!config.enable) return;

    /// CREATE INSTANCE ADS
    _analytics.clear();
    for (var provider in _config.providers) {
      BaseAnalytics? adProvider;
      if (!_analytics.containsKey(provider)) {
        if (provider == AnalyticsProvider.google) {
          adProvider = GoogleAnalytics();
        } else if (provider == AnalyticsProvider.huawei) {
          adProvider = HuaweiAnalytics();
        }
      }
      if (adProvider != null) {
        final done = await adProvider.initial();
        if (done) _analytics[provider] = adProvider;
      }
    }
  }

  @override
  Future<void> sendEvent(String name, Map<String, dynamic> parameters) async {
    for (BaseAnalytics item in _analytics.values) {
      if (item.isSupported) item.sendEvent(name, parameters);
    }
  }
}
