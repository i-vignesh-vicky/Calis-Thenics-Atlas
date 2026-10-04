import 'package:atlas/features/onboarding/models/onboarding_data.dart';
import 'package:atlas/features/onboarding/notifiers/onboarding_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OnboardingNotifier notifier;

  setUp(() => notifier = OnboardingNotifier());

  group('OnboardingNotifier — basic fields', () {
    test('updateName reflects in data', () {
      notifier.updateName('Alice');
      expect(notifier.data.firstName, 'Alice');
    });

    test('setSex reflects in data', () {
      notifier.setSex(BiologicalSex.female);
      expect(notifier.data.sex, BiologicalSex.female);
    });

    test('setWeight and setHeight reflect in data', () {
      notifier.setWeight(75);
      notifier.setHeight(175);
      expect(notifier.data.weightKg, 75);
      expect(notifier.data.heightCm, 175);
    });

    test('setExperience reflects in data', () {
      notifier.setExperience(ExperienceLevel.intermediate);
      expect(notifier.data.experienceLevel, ExperienceLevel.intermediate);
    });

    test('setPrimaryGoal reflects in data', () {
      notifier.setPrimaryGoal(TrainingGoal.strength);
      expect(notifier.data.primaryGoal, TrainingGoal.strength);
    });

    test('setFrequency reflects in data', () {
      notifier.setFrequency(TrainingFrequency.threeDays);
      expect(notifier.data.frequency, TrainingFrequency.threeDays);
    });

    test('setSessionLength reflects in data', () {
      notifier.setSessionLength(SessionLength.medium);
      expect(notifier.data.sessionLength, SessionLength.medium);
    });
  });

  group('OnboardingNotifier — location and equipment (multi-select)', () {
    test('toggleLocation adds location', () {
      notifier.toggleLocation(TrainingLocation.gym);
      expect(notifier.data.locations, contains(TrainingLocation.gym));
    });

    test('toggleLocation removes location when already selected', () {
      notifier.toggleLocation(TrainingLocation.gym);
      notifier.toggleLocation(TrainingLocation.gym);
      expect(notifier.data.locations, isEmpty);
    });

    test('toggleEquipment adds equipment', () {
      notifier.toggleEquipment(Equipment.pullUpBar);
      expect(notifier.data.equipment, contains(Equipment.pullUpBar));
    });

    test('toggleEquipment removes equipment when already selected', () {
      notifier.toggleEquipment(Equipment.pullUpBar);
      notifier.toggleEquipment(Equipment.pullUpBar);
      expect(notifier.data.equipment, isEmpty);
    });
  });

  group('OnboardingNotifier — injuries', () {
    test('toggleInjury adds injury area', () {
      notifier.toggleInjury(InjuryArea.shoulder);
      expect(notifier.data.injuries, contains(InjuryArea.shoulder));
    });

    test('toggleInjury removes injury area when already selected', () {
      notifier.toggleInjury(InjuryArea.shoulder);
      notifier.toggleInjury(InjuryArea.shoulder);
      expect(notifier.data.injuries, isEmpty);
    });

    test('multiple injury areas can be selected independently', () {
      notifier.toggleInjury(InjuryArea.shoulder);
      notifier.toggleInjury(InjuryArea.knee);
      expect(notifier.data.injuries,
          containsAll([InjuryArea.shoulder, InjuryArea.knee]));
    });

    test('clearInjuries empties the list', () {
      notifier.toggleInjury(InjuryArea.shoulder);
      notifier.toggleInjury(InjuryArea.wrist);
      notifier.clearInjuries();
      expect(notifier.data.injuries, isEmpty);
    });
  });

  group('OnboardingNotifier — assessment', () {
    test('setAssessment stores all metric fields', () {
      const result = AssessmentResult(pullUps: 10, pushUps: 20, dips: 15);
      notifier.setAssessment(result);
      expect(notifier.data.assessment?.pullUps, 10);
      expect(notifier.data.assessment?.pushUps, 20);
      expect(notifier.data.assessment?.dips, 15);
    });

    test('setAssessment with partial metrics stores nulls for missing fields', () {
      const result = AssessmentResult(pullUps: 5);
      notifier.setAssessment(result);
      expect(notifier.data.assessment?.pullUps, 5);
      expect(notifier.data.assessment?.pushUps, isNull);
      expect(notifier.data.assessment?.dips, isNull);
    });

    test('assessment starts null before any setAssessment call', () {
      expect(notifier.data.assessment, isNull);
    });
  });

  group('OnboardingNotifier — reset', () {
    test('reset clears all data and completed flag', () {
      notifier.updateName('Alice');
      notifier.toggleInjury(InjuryArea.shoulder);
      notifier.setAssessment(const AssessmentResult(pullUps: 5));
      notifier.reset();
      expect(notifier.data.firstName, '');
      expect(notifier.data.injuries, isEmpty);
      expect(notifier.data.assessment, isNull);
      expect(notifier.completed, isFalse);
    });
  });

  group('OnboardingNotifier — notifications', () {
    test('notifyListeners is called on each mutation', () {
      var callCount = 0;
      notifier.addListener(() => callCount++);
      notifier.updateName('Bob');
      notifier.setSex(BiologicalSex.male);
      notifier.toggleInjury(InjuryArea.wrist);
      notifier.setAssessment(const AssessmentResult(dips: 8));
      expect(callCount, 4);
    });
  });
}
