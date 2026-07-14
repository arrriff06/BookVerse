import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserService {
  AdminUserService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getUsers() {
    return _firestore
        .collection("users")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static Future<void> changeRole(
      String uid,
      String role,
      ) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({
      "role": role,
    });
  }

  static Future<void> deleteUser(
      String uid,
      ) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .delete();
  }
}