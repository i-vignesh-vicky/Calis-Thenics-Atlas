import 'package:flutter/foundation.dart';

import 'auth_service.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._service);

  final AuthService _service;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> initialize() async {
    _isAuthenticated = await _service.isAuthenticated();
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  void onLoginSuccess() {
    _isAuthenticated = true;
    notifyListeners();
  }
}
