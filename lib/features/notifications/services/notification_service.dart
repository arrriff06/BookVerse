import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notification_model.dart';

class NotificationService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static Stream<List<NotificationModel>>
  getNotifications() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection("notifications")
        .where("uid", isEqualTo: uid)
        .orderBy("createdAt",
        descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => NotificationModel
            .fromFirestore(e),
      )
          .toList(),
    );
  }

  static Future<void> markAsRead(
      String id) async {
    await _firestore
        .collection("notifications")
        .doc(id)
        .update({
      "isRead": true,
    });
  }

  static Future<void> sendNotification({
    required String uid,
    required String title,
    required String body,
    required String type,
  }) async {
    await _firestore
        .collection("notifications")
        .add({
      "uid": uid,
      "title": title,
      "body": body,
      "type": type,
      "isRead": false,
      "createdAt":
      FieldValue.serverTimestamp(),
    });
  }
}