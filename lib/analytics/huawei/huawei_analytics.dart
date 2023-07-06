import 'package:fluttering/fluttering.dart';
import 'package:fluttering_analytics/analytics/models/analytics_provider.dart';
import 'package:fluttering_analytics/base_analytics.dart';
import 'package:huawei_analytics/huawei_analytics.dart';

class HuaweiAnalytics extends BaseAnalytics {
  late HMSAnalytics hmsAnalytics;

  @override
  Future<bool> initial() async {
    try {
      _isSupported = await CurrentPlatform.instance.isHmsAvailable;
      Debug.log('HuaweiAnalytics is supported $_isSupported');
      hmsAnalytics = await HMSAnalytics.getInstance();
      return true;
    } catch (error) {
      Debug.log("HuaweiAnalytics initial error $error");
    }
    return false;
  }

  bool _isSupported = CurrentPlatform.instance.isHuawei;

  @override
  bool get isSupported => _isSupported;

  @override
  AnalyticsProvider get provider => AnalyticsProvider.huawei;

  @override
  Future<void> sendEvent(String name, Map<String, dynamic> parameters) async {
    return hmsAnalytics.onEvent(name, parameters);
  }
}
