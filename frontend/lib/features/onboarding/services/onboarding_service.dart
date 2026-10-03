import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/services/token_storage.dart';
import '../models/onboarding_data.dart';

class OnboardingException implements Exception {
  const OnboardingException(this.message);
  final String message;
  @override
  String toString() => message;
}

class OnboardingService {
  OnboardingService({
    required this.storage,
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final TokenStorage storage;
  final String baseUrl;
  final http.Client _client;

  Future<void> completeOnboarding(OnboardingData data) async {
    final token = await storage.getAccessToken();
    if (token == null) throw const OnboardingException('Not authenticated.');

    final assessment = data.assessment;

    final body = <String, dynamic>{
      'firstName': data.firstName,
      if (data.sex != null) 'sex': data.sex!.name,
      if (data.weightKg != null) 'weightKg': data.weightKg,
      if (data.heightCm != null) 'heightCm': data.heightCm,
      if (data.experienceLevel != null)
        'experienceLevel': data.experienceLevel!.name,
      if (data.primaryGoal != null) 'primaryGoal': data.primaryGoal!.name,
      'locations': data.locations.map((l) => l.name).toList(),
      'equipment': data.equipment.map((e) => e.name).toList(),
      if (data.frequency != null) 'frequency': data.frequency!.name,
      if (data.sessionLength != null) 'sessionLength': data.sessionLength!.name,
      'injuries': data.injuries.map((i) => i.name).toList(),
      if (assessment != null)
        'assessment': {
          if (assessment.pullUps != null) 'pullUps': assessment.pullUps,
          if (assessment.pushUps != null) 'pushUps': assessment.pushUps,
          if (assessment.dips != null) 'dips': assessment.dips,
        },
    };

    final res = await _client.post(
      Uri.parse('$baseUrl/api/v1/profile/onboarding'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 204) return;

    throw const OnboardingException('Failed to save profile. Please try again.');
  }
}
