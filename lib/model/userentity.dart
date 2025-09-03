class UserEntity {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final bool isVerified;
  final double accountBalance;
  final DateTime lastLogin;
  final Profile profile;
  final String? referralCode;

  UserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.accountBalance,
    required this.lastLogin,
    required this.profile,
    this.referralCode,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isVerified: json['isVerified'],
      accountBalance: json['accountBalance'].toDouble(),
      lastLogin: DateTime.parse(json['lastLogin']),
      profile: Profile.fromJson(json['profile']),
      referralCode: json['referralCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'isVerified': isVerified,
      'accountBalance': accountBalance,
      'lastLogin': lastLogin.toIso8601String(),
      'profile': profile.toJson(),
      'referralCode': referralCode,
    };
  }
}

class Profile {
  final String bio;
  final String location;
  final String avatarUrl;
  final String? linkedin;

  Profile({
    required this.bio,
    required this.location,
    required this.avatarUrl,
    this.linkedin,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      bio: json['bio'],
      location: json['location'],
      avatarUrl: json['avatarUrl'],
      linkedin: json['linkedin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bio': bio,
      'location': location,
      'avatarUrl': avatarUrl,
      'linkedin': linkedin,
    };
  }
}
