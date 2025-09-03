// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//   static final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//   );

//   static Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // Start the sign-in flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null; // user canceled

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Firebase credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final userCredential =
//           await _auth.signInWithCredential(credential);

//       final user = userCredential.user;
//       if (user == null) return null;

//       final userDoc =
//           FirebaseFirestore.instance.collection('users').doc(user.uid);
//       final docSnapshot = await userDoc.get();

//       if (!docSnapshot.exists) {
//         await userDoc.set({
//           'uid': user.uid,
//           'name': user.displayName ?? '',
//           'email': user.email ?? '',
//           'photoURL': user.photoURL ?? '',
//           'provider': 'google',
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//       }

//       return userCredential;
//     } catch (e) {
//       print('Google Sign-In error: $e');
//       rethrow;
//     }
//   }

//   static Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }

//   static User? getCurrentUser() => _auth.currentUser;
// }
