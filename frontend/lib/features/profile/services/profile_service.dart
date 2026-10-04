import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../core/services/token_storage.dart';
import '../models/profile_data.dart';

class ProfileException implements Exception {
  const ProfileException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ProfileService {
  ProfileService({required this.storage, required this.baseUrl});

  final TokenStorage storage;
  final String baseUrl;

  Future<ProfileData> getProfile() async {
    final token = await storage.getAccessToken();
    log('[ProfileService] token=${token == null ? "NULL" : "present"}', name: 'atlas');
    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    log('[ProfileService] GET /profile → ${res.statusCode}: ${res.body}', name: 'atlas');
    if (res.statusCode == 200) {
      return ProfileData.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    }
    throw ProfileException('Profile load failed (${res.statusCode}): ${res.body}');
  }

  Future<void> updateProfile({String? displayName}) async {
    final token = await storage.getAccessToken();
    final body = <String, dynamic>{};
    if (displayName != null) body['displayName'] = displayName;
    if (body.isEmpty) return;

    final res = await http.patch(
      Uri.parse('$baseUrl/api/v1/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (res.statusCode != 204) {
      throw const ProfileException('Failed to update profile.');
    }
  }
}
