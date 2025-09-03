import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> saveUserInfo(String username, String email) async {
    try {
      await firestore.collection('users').add({
        'username': username,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('User info saved to Firestore!');
    } catch (e) {
      print('Error saving user info: $e');
    }
  }
}
