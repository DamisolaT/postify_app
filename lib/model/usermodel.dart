class UserModel {
  final String uid;
  final String username;
  final String email;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
  });

  // Factory constructor to create UserModel from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json, String documentId) {
    return UserModel(
      uid: documentId,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  // Convert UserModel to JSON (for uploading to Firestore)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
    };
  }
}
