import 'package:flutter/foundation.dart';

import '../models/profile_data.dart';
import 'profile_service.dart';

class ProfileNotifier extends ChangeNotifier {
  ProfileNotifier(this._service);

  final ProfileService _service;

  ProfileData? _data;
  bool _loading = false;
  String? _error;

  ProfileData? get data => _data;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _data = await _service.getProfile();
    } on ProfileException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Failed to load profile.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    await _service.updateProfile(displayName: displayName);
    if (_data != null) {
      _data = ProfileData(
        id: _data!.id,
        email: _data!.email,
        displayName: displayName,
        createdAt: _data!.createdAt,
        profile: _data!.profile,
      );
      notifyListeners();
    }
  }
}
