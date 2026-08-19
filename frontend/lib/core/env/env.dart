import 'package:flutter/foundation.dart';

/// Thin environment accessor.
///
/// Values are resolved from compile-time --dart-define flags so nothing
/// sensitive is baked into the release binary.
abstract final class Env {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000/api/v1',
  );

  static bool get isDebug => kDebugMode;
}
