import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/services/token_storage.dart';
import 'features/auth/services/auth_notifier.dart';
import 'features/auth/services/auth_service.dart';

const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5000',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  const tokenStorage = TokenStorage(storage);
  final authService = AuthService(storage: tokenStorage, baseUrl: _apiBaseUrl);
  final authNotifier = AuthNotifier(authService);
  await authNotifier.initialize();

  final router = createRouter(authNotifier, authService);

  runApp(App(routerConfig: router));
}
