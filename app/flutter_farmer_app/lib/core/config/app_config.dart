class AppConfig {
  AppConfig._();

  static const String appName = 'ShrimpGuard AI';

  // Override at build time:
  // flutter run --dart-define=API_BASE_URL=http://<host>:3000/api/v1
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api/v1',
  );

  static const Duration requestTimeout = Duration(seconds: 20);
}
