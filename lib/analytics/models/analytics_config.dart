// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluttering_analytics/analytics/models/analytics_provider.dart';

class AnalyticsConfig {
  final bool enable;
  final List<AnalyticsProvider> providers;
  const AnalyticsConfig({
    this.enable = false,
    this.providers = const [AnalyticsProvider.google],
  });

  AnalyticsConfig copyWith({
    bool? enable,
    List<AnalyticsProvider>? providers,
  }) {
    return AnalyticsConfig(
      enable: enable ?? this.enable,
      providers: providers ?? this.providers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enable': enable,
      'providers': providers.map((x) => x.name).toList(),
    };
  }

  factory AnalyticsConfig.fromMap(Map<String, dynamic> map) {
    return AnalyticsConfig(
      enable: map['enable'] as bool,
      providers: List<AnalyticsProvider>.from(map['providers']?.map((e) =>
          AnalyticsProvider.values.firstWhere((element) => element.name == e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalyticsConfig.fromJson(String source) =>
      AnalyticsConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AnalyticsConfig(enable: $enable, providers: $providers)';

  @override
  bool operator ==(covariant AnalyticsConfig other) {
    if (identical(this, other)) return true;

    return other.enable == enable && listEquals(other.providers, providers);
  }

  @override
  int get hashCode => enable.hashCode ^ providers.hashCode;
}
