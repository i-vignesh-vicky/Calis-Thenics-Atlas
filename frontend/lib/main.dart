import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/services/onboarding_storage.dart';
import 'core/services/token_storage.dart';
import 'features/auth/services/auth_notifier.dart';
import 'features/auth/services/auth_service.dart';
import 'features/onboarding/services/onboarding_service.dart';
import 'features/profile/services/profile_notifier.dart';
import 'features/profile/services/profile_service.dart';

const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:5028',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  const tokenStorage = TokenStorage(storage);
  const onboardingStorage = OnboardingStorage(storage);
  final authService = AuthService(storage: tokenStorage, baseUrl: _apiBaseUrl);
  final onboardingService = OnboardingService(storage: tokenStorage, baseUrl: _apiBaseUrl);
  final profileService = ProfileService(storage: tokenStorage, baseUrl: _apiBaseUrl);
  final authNotifier = AuthNotifier(authService);
  final profileNotifier = ProfileNotifier(profileService);
  await authNotifier.initialize();

  final router = createRouter(
    authNotifier,
    authService,
    onboardingStorage,
    onboardingService,
    profileNotifier,
  );

  runApp(App(routerConfig: router));
}
