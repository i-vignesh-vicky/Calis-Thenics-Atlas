enum BiologicalSex {
  male,
  female;

  String get label => this == BiologicalSex.male ? 'Male' : 'Female';
}

enum ExperienceLevel {
  justStarting,
  beginner,
  intermediate,
  advanced;

  String get label => switch (this) {
        ExperienceLevel.justStarting => 'Just Starting',
        ExperienceLevel.beginner => 'Beginner',
        ExperienceLevel.intermediate => 'Intermediate',
        ExperienceLevel.advanced => 'Advanced',
      };

  String get subtitle => switch (this) {
        ExperienceLevel.justStarting => 'New to training',
        ExperienceLevel.beginner => 'Building basics',
        ExperienceLevel.intermediate => 'Training often',
        ExperienceLevel.advanced => 'Years of experience',
      };
}

enum TrainingGoal {
  strength,
  skills,
  muscle,
  mobility,
  consistency;

  String get label => switch (this) {
        TrainingGoal.strength => 'Strength',
        TrainingGoal.skills => 'Skill Progression',
        TrainingGoal.muscle => 'Muscle Building',
        TrainingGoal.mobility => 'Mobility',
        TrainingGoal.consistency => 'Training Consistently',
      };

  String get subtitle => switch (this) {
        TrainingGoal.strength => 'Get stronger each session',
        TrainingGoal.skills => 'Master movements like muscle-ups',
        TrainingGoal.muscle => 'Build size and definition',
        TrainingGoal.mobility => 'Move better, feel better',
        TrainingGoal.consistency => 'Build a lasting habit',
      };
}

enum TrainingLocation {
  home,
  gym,
  outdoors;

  String get label => switch (this) {
        TrainingLocation.home => 'Home',
        TrainingLocation.gym => 'Gym',
        TrainingLocation.outdoors => 'Outdoors',
      };
}

enum Equipment {
  bodyweightOnly,
  pullUpBar,
  rings,
  parallettes,
  resistanceBands,
  dumbbells,
  fullGym;

  String get label => switch (this) {
        Equipment.bodyweightOnly => 'Bodyweight Only',
        Equipment.pullUpBar => 'Pull-up Bar',
        Equipment.rings => 'Rings',
        Equipment.parallettes => 'Parallettes',
        Equipment.resistanceBands => 'Resistance Bands',
        Equipment.dumbbells => 'Dumbbells',
        Equipment.fullGym => 'Full Gym',
      };
}

enum TrainingFrequency {
  twoDays,
  threeDays,
  fourDays,
  fivePlus;

  String get label => switch (this) {
        TrainingFrequency.twoDays => '2×  / week',
        TrainingFrequency.threeDays => '3×  / week',
        TrainingFrequency.fourDays => '4×  / week',
        TrainingFrequency.fivePlus => '5+  / week',
      };

  String get subtitle => switch (this) {
        TrainingFrequency.twoDays => 'Easy to build a habit',
        TrainingFrequency.threeDays => 'Balanced progression',
        TrainingFrequency.fourDays => 'Consistent commitment',
        TrainingFrequency.fivePlus => 'High intensity focus',
      };
}

enum SessionLength {
  short,
  medium,
  long;

  String get label => switch (this) {
        SessionLength.short => 'Under 30 min',
        SessionLength.medium => '30–60 min',
        SessionLength.long => '60+ min',
      };

  String get subtitle => switch (this) {
        SessionLength.short => 'Quick, focused sessions',
        SessionLength.medium => 'Balanced work and rest',
        SessionLength.long => 'Deep skill work, more volume',
      };
}

enum InjuryArea {
  shoulder,
  wrist,
  elbow,
  lowerBack,
  knee,
  neck;

  String get label => switch (this) {
        InjuryArea.shoulder => 'Shoulder',
        InjuryArea.wrist => 'Wrist',
        InjuryArea.elbow => 'Elbow',
        InjuryArea.lowerBack => 'Lower Back',
        InjuryArea.knee => 'Knee',
        InjuryArea.neck => 'Neck',
      };
}

class AssessmentResult {
  final int? pullUps;
  final int? pushUps;
  final int? dips;

  const AssessmentResult({
    this.pullUps,
    this.pushUps,
    this.dips,
  });
}

class OnboardingData {
  String firstName;
  BiologicalSex? sex;
  int? weightKg;
  int? heightCm;
  ExperienceLevel? experienceLevel;
  TrainingGoal? primaryGoal;
  List<TrainingLocation> locations;
  List<Equipment> equipment;
  TrainingFrequency? frequency;
  SessionLength? sessionLength;
  List<InjuryArea> injuries;
  AssessmentResult? assessment;

  OnboardingData({
    this.firstName = '',
    this.sex,
    this.weightKg,
    this.heightCm,
    this.experienceLevel,
    this.primaryGoal,
    List<TrainingLocation>? locations,
    List<Equipment>? equipment,
    this.frequency,
    this.sessionLength,
    List<InjuryArea>? injuries,
    this.assessment,
  })  : locations = locations ?? [],
        equipment = equipment ?? [],
        injuries = injuries ?? [];

  OnboardingData copyWith({
    String? firstName,
    BiologicalSex? sex,
    int? weightKg,
    int? heightCm,
    ExperienceLevel? experienceLevel,
    TrainingGoal? primaryGoal,
    List<TrainingLocation>? locations,
    List<Equipment>? equipment,
    TrainingFrequency? frequency,
    SessionLength? sessionLength,
    List<InjuryArea>? injuries,
    AssessmentResult? assessment,
  }) {
    return OnboardingData(
      firstName: firstName ?? this.firstName,
      sex: sex ?? this.sex,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      locations: locations ?? this.locations,
      equipment: equipment ?? this.equipment,
      frequency: frequency ?? this.frequency,
      sessionLength: sessionLength ?? this.sessionLength,
      injuries: injuries ?? this.injuries,
      assessment: assessment ?? this.assessment,
    );
  }
}
