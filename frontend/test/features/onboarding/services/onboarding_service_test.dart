import 'dart:convert';

import 'package:atlas/features/onboarding/models/onboarding_data.dart';
import 'package:atlas/features/onboarding/services/onboarding_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:atlas/core/services/token_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

// Fake TokenStorage that never touches a platform channel.
class _FakeTokenStorage extends TokenStorage {
  _FakeTokenStorage(this._fixedToken)
      : super(const FlutterSecureStorage());

  final String? _fixedToken;

  @override
  Future<String?> getAccessToken() async => _fixedToken;
}

void main() {
  const baseUrl = 'https://api.test';

  http.Request? captured;

  MockClient mockClient(int statusCode) {
    return MockClient((req) async {
      captured = req;
      return http.Response('', statusCode);
    });
  }

  OnboardingService makeService({int status = 204, String? token = 'tok'}) {
    return OnboardingService(
      storage: _FakeTokenStorage(token),
      baseUrl: baseUrl,
      client: mockClient(status),
    );
  }

  OnboardingData baseData() => OnboardingData(
        firstName: 'Alice',
        sex: BiologicalSex.female,
        weightKg: 60,
        heightCm: 165,
        experienceLevel: ExperienceLevel.beginner,
        primaryGoal: TrainingGoal.strength,
        frequency: TrainingFrequency.threeDays,
        sessionLength: SessionLength.medium,
      );

  setUp(() => captured = null);

  group('OnboardingService — authentication', () {
    test('throws OnboardingException when token is null', () {
      final svc = makeService(token: null);
      expect(
        () => svc.completeOnboarding(baseData()),
        throwsA(isA<OnboardingException>()),
      );
    });

    test('sends Bearer token in Authorization header', () async {
      await makeService().completeOnboarding(baseData());
      expect(captured!.headers['Authorization'], 'Bearer tok');
    });
  });

  group('OnboardingService — request shape', () {
    test('POSTs to the correct endpoint', () async {
      await makeService().completeOnboarding(baseData());
      expect(captured!.url.toString(), '$baseUrl/api/v1/profile/onboarding');
      expect(captured!.method, 'POST');
    });

    test('sends Content-Type application/json', () async {
      await makeService().completeOnboarding(baseData());
      expect(captured!.headers['Content-Type'], contains('application/json'));
    });

    test('includes basic profile fields in body', () async {
      await makeService().completeOnboarding(baseData());
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body['firstName'], 'Alice');
      expect(body['sex'], 'female');
      expect(body['weightKg'], 60);
      expect(body['heightCm'], 165);
      expect(body['experienceLevel'], 'beginner');
      expect(body['primaryGoal'], 'strength');
      expect(body['frequency'], 'threeDays');
      expect(body['sessionLength'], 'medium');
    });
  });

  group('OnboardingService — assessment', () {
    test('omits assessment key when data.assessment is null', () async {
      final data = baseData(); // no assessment set
      await makeService().completeOnboarding(data);
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body.containsKey('assessment'), isFalse);
    });

    test('includes assessment key when assessment is set', () async {
      final data = baseData();
      data.assessment = const AssessmentResult(pullUps: 10, pushUps: 20, dips: 15);
      await makeService().completeOnboarding(data);
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body.containsKey('assessment'), isTrue);
      final a = body['assessment'] as Map<String, dynamic>;
      expect(a['pullUps'], 10);
      expect(a['pushUps'], 20);
      expect(a['dips'], 15);
    });

    test('omits null metric fields within assessment', () async {
      final data = baseData();
      data.assessment = const AssessmentResult(pullUps: 5);
      await makeService().completeOnboarding(data);
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      final a = body['assessment'] as Map<String, dynamic>;
      expect(a['pullUps'], 5);
      expect(a.containsKey('pushUps'), isFalse);
      expect(a.containsKey('dips'), isFalse);
    });
  });

  group('OnboardingService — injuries', () {
    test('serializes selected injuries as name strings', () async {
      final data = baseData();
      data.injuries.addAll([InjuryArea.shoulder, InjuryArea.knee]);
      await makeService().completeOnboarding(data);
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body['injuries'], containsAll(['shoulder', 'knee']));
    });

    test('sends empty injuries list when no injuries selected', () async {
      await makeService().completeOnboarding(baseData());
      final body = jsonDecode(captured!.body) as Map<String, dynamic>;
      expect(body['injuries'], isEmpty);
    });
  });

  group('OnboardingService — response handling', () {
    test('completes normally on 204 response', () async {
      expect(() => makeService(status: 204).completeOnboarding(baseData()),
          returnsNormally);
    });

    test('throws OnboardingException on 400 response', () async {
      expect(
        () => makeService(status: 400).completeOnboarding(baseData()),
        throwsA(isA<OnboardingException>()),
      );
    });

    test('throws OnboardingException on 500 response', () async {
      expect(
        () => makeService(status: 500).completeOnboarding(baseData()),
        throwsA(isA<OnboardingException>()),
      );
    });

    test('throws OnboardingException on 401 response', () async {
      expect(
        () => makeService(status: 401).completeOnboarding(baseData()),
        throwsA(isA<OnboardingException>()),
      );
    });
  });
}
