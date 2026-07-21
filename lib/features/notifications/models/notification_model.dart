import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String uid;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final Timestamp createdAt;

  const NotificationModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromFirestore(
      DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return NotificationModel(
      id: doc.id,
      uid: data["uid"] ?? "",
      title: data["title"] ?? "",
      body: data["body"] ?? "",
      type: data["type"] ?? "",
      isRead: data["isRead"] ?? false,
      createdAt:
      data["createdAt"] ?? Timestamp.now(),
    );
  }
}