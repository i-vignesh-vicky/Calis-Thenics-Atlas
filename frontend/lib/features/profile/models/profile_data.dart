class ProfileData {
  const ProfileData({
    required this.id,
    required this.email,
    required this.displayName,
    required this.createdAt,
    this.profile,
  });

  final String id;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final ProfileDetails? profile;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json['id'] as String,
        email: json['email'] as String,
        displayName: json['displayName'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        profile: json['profile'] != null
            ? ProfileDetails.fromJson(json['profile'] as Map<String, dynamic>)
            : null,
      );

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

class ProfileDetails {
  const ProfileDetails({
    required this.firstName,
    this.experienceLevel,
    this.primaryGoal,
    this.weightKg,
    this.heightCm,
  });

  final String firstName;
  final String? experienceLevel;
  final String? primaryGoal;
  final int? weightKg;
  final int? heightCm;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
        firstName: json['firstName'] as String,
        experienceLevel: json['experienceLevel'] as String?,
        primaryGoal: json['primaryGoal'] as String?,
        weightKg: json['weightKg'] as int?,
        heightCm: json['heightCm'] as int?,
      );
}
