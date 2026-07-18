import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class AdminUserService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Get all users
  static Stream<List<UserModel>> getUsers() {
    return _firestore
        .collection('users')
        .orderBy('name')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList(),
    );
  }

  /// Delete User
  static Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  /// Block / Unblock User
  static Future<void> blockUser(
      String uid,
      bool blocked,
      ) async {
    await _firestore.collection('users').doc(uid).update({
      'blocked': blocked,
    });
  }

  /// Change Role
  static Future<void> changeRole(
      String uid,
      String role,
      ) async {
    await _firestore.collection('users').doc(uid).update({
      'role': role,
    });
  }

  /// Get Single User
  static Future<UserModel> getUser(String uid) async {
    final doc =
    await _firestore.collection('users').doc(uid).get();

    return UserModel.fromFirestore(doc);
  }
}