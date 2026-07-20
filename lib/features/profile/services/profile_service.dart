import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileService {
  ProfileService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;
  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  static User get currentUser => _auth.currentUser!;

  //==================================================
  // Get Profile
  //==================================================

  static Future<DocumentSnapshot<Map<String, dynamic>>>
  getUserProfile() async {
    return _firestore
        .collection("users")
        .doc(currentUser.uid)
        .get();
  }

  //==================================================
  // Logout
  //==================================================

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  //==================================================
  // Upload Profile Image
  //==================================================

  static Future<String?> _uploadProfileImage(
      File image) async {
    final ref = _storage
        .ref()
        .child("profile_images")
        .child("${currentUser.uid}.jpg");

    await ref.putFile(image);

    return await ref.getDownloadURL();
  }

  //==================================================
  // Update Profile
  //==================================================

  static Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    try {
      String? photoUrl;

      //----------------------------------------
      // Upload Image
      //----------------------------------------

      if (image != null) {
        photoUrl = await _uploadProfileImage(image);
      }

      //----------------------------------------
      // Update Firebase Auth
      //----------------------------------------

      if (name != currentUser.displayName) {
        await currentUser.updateDisplayName(name);
      }

      if (email != currentUser.email) {
        await currentUser.verifyBeforeUpdateEmail(
          email,
        );
      }

      //----------------------------------------
      // Firestore Data
      //----------------------------------------

      final Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      if (photoUrl != null) {
        data["photoUrl"] = photoUrl;
      }

      //----------------------------------------
      // Update Firestore
      //----------------------------------------

      await _firestore
          .collection("users")
          .doc(currentUser.uid)
          .update(data);

      //----------------------------------------
      // Reload User
      //----------------------------------------

      await currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        throw Exception(
          "Please sign in again before changing your email.",
        );
      }

      throw Exception(e.message);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}