import 'package:flutter/foundation.dart';

enum AnalyticsProvider {
  google,
  huawei,
}

extension AnalyticsProviderExtension on AnalyticsProvider {
  String get content => describeEnum(this);
}
