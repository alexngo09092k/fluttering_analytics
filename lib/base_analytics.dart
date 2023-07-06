import 'analytics/models/analytics_provider.dart';

abstract class BaseAnalytics {
  AnalyticsProvider get provider;

  bool get isSupported;

  Future<bool> initial();

  Future<void> sendEvent(String name, Map<String, dynamic> parameters);
}
