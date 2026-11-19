# fluttering_analytics

**Unified analytics module for the [Fluttering](https://pub.dev/packages/fluttering) toolkit.**

Supports **Firebase Analytics** and **Huawei Analytics Kit** with a single event / screen-tracking API.

---

## Features

- Entry point: `AwesomeAnalytics`
- Providers: Google (Firebase Analytics) + Huawei Analytics
- `sendEvent(name, parameters)`
- Optional route / screen observation via `ProviderObserver`
- Config-driven (`AnalyticsConfig`)

---

## Getting started

```yaml
dependencies:
  fluttering: ^3.0.0
  fluttering_analytics: ^3.0.2
```

### Platform setup

- Firebase: FlutterFire / `google-services`
- Huawei: Analytics Kit + `agconnect-services.json`

---

## Usage

```dart
import 'package:fluttering_analytics/fluttering_analytics.dart';

AwesomeAnalytics.instance.initial(
  AnalyticsConfig(
    enable: true,
    providers: [
      AnalyticsProvider.google,
      AnalyticsProvider.huawei,
    ],
  ),
);

await AwesomeAnalytics.instance.sendEvent(
  'button_click',
  {'screen': 'home', 'id': 'cta_primary'},
);
```

Register with Fluttering providers if you want automatic screen tracking via route observer.

---

## Additional information

- Depends on the core **fluttering** package.
- Author: Brennan Ngo / ThemePlace
- License: MIT
