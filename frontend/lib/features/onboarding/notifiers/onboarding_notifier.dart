import 'package:flutter/foundation.dart';

import '../models/onboarding_data.dart';
import '../services/onboarding_service.dart';

class OnboardingNotifier extends ChangeNotifier {
  OnboardingData _data = OnboardingData();
  bool _completed = false;
  bool _submitting = false;

  OnboardingData get data => _data;
  bool get completed => _completed;
  bool get isSubmitting => _submitting;

  void updateName(String name) {
    _data = _data.copyWith(firstName: name);
    notifyListeners();
  }

  void setSex(BiologicalSex sex) {
    _data = _data.copyWith(sex: sex);
    notifyListeners();
  }

  void setWeight(int kg) {
    _data = _data.copyWith(weightKg: kg);
    notifyListeners();
  }

  void setHeight(int cm) {
    _data = _data.copyWith(heightCm: cm);
    notifyListeners();
  }

  void setExperience(ExperienceLevel level) {
    _data = _data.copyWith(experienceLevel: level);
    notifyListeners();
  }

  void setPrimaryGoal(TrainingGoal goal) {
    _data = _data.copyWith(primaryGoal: goal);
    notifyListeners();
  }

  void toggleLocation(TrainingLocation loc) {
    final updated = List<TrainingLocation>.from(_data.locations);
    updated.contains(loc) ? updated.remove(loc) : updated.add(loc);
    _data = _data.copyWith(locations: updated);
    notifyListeners();
  }

  void toggleEquipment(Equipment eq) {
    final updated = List<Equipment>.from(_data.equipment);
    updated.contains(eq) ? updated.remove(eq) : updated.add(eq);
    _data = _data.copyWith(equipment: updated);
    notifyListeners();
  }

  void setFrequency(TrainingFrequency freq) {
    _data = _data.copyWith(frequency: freq);
    notifyListeners();
  }

  void setSessionLength(SessionLength length) {
    _data = _data.copyWith(sessionLength: length);
    notifyListeners();
  }

  void toggleInjury(InjuryArea area) {
    final updated = List<InjuryArea>.from(_data.injuries);
    updated.contains(area) ? updated.remove(area) : updated.add(area);
    _data = _data.copyWith(injuries: updated);
    notifyListeners();
  }

  void clearInjuries() {
    _data = _data.copyWith(injuries: []);
    notifyListeners();
  }

  void setAssessment(AssessmentResult result) {
    _data = _data.copyWith(assessment: result);
    notifyListeners();
  }

  Future<void> submit(OnboardingService service) async {
    _submitting = true;
    notifyListeners();
    try {
      await service.completeOnboarding(_data);
      _completed = true;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  void reset() {
    _data = OnboardingData();
    _completed = false;
    notifyListeners();
  }
}
