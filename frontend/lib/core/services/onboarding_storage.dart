import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingStorage {
  const OnboardingStorage(this._storage);

  static const _key = 'atlas_onboarding_complete';
  final FlutterSecureStorage _storage;

  Future<bool> isCompleted() async {
    final val = await _storage.read(key: _key);
    return val == 'true';
  }

  Future<void> setCompleted() async {
    await _storage.write(key: _key, value: 'true');
  }

  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}
