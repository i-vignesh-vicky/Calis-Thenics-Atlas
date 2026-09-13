import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/services/token_storage.dart';

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class AuthService {
  AuthService({required this.storage, required this.baseUrl});

  final TokenStorage storage;
  final String baseUrl;

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'displayName': displayName,
      }),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      await storage.saveTokens(
        accessToken: body['accessToken'] as String,
        refreshToken: body['refreshToken'] as String,
      );
      return;
    }

    if (res.statusCode == 409) {
      throw const AuthException('An account with this email already exists.');
    }
    throw const AuthException('Registration failed. Please try again.');
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      await storage.saveTokens(
        accessToken: body['accessToken'] as String,
        refreshToken: body['refreshToken'] as String,
      );
      return;
    }

    if (res.statusCode == 401) {
      throw const AuthException('Invalid email or password.');
    }
    throw const AuthException('Login failed. Please try again.');
  }

  Future<void> logout() async {
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken != null) {
      http
          .post(
            Uri.parse('$baseUrl/api/v1/auth/logout'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          )
          .timeout(const Duration(seconds: 5))
          .ignore();
    }
    await storage.clearTokens();
  }

  Future<bool> isAuthenticated() => storage.hasTokens();
}
