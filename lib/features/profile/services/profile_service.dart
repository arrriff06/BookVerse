import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileService {

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;



  static Future<DocumentSnapshot<Map<String, dynamic>>>
  getUserProfile() async {

    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }


    return await _firestore
        .collection("users")
        .doc(user.uid)
        .get();
  }



  static Future<void> createUserProfile(
      User user) async {


    final userRef = _firestore
        .collection("users")
        .doc(user.uid);


    final snapshot = await userRef.get();


    if (!snapshot.exists) {

      await userRef.set({

        "name": user.displayName ?? "",

        "email": user.email ?? "",

        "photoUrl": user.photoURL ?? "",

        "phone": user.phoneNumber ?? "",

        "role": "user",

        "membership": "free",

        "createdAt": Timestamp.now(),

      });

    }

  }



  static Future<void> logout() async {

    await _auth.signOut();

  }

}