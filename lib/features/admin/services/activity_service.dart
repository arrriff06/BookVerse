import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/activity_model.dart';

class ActivityService {
  ActivityService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<List<ActivityModel>> recentActivities() async {
    List<ActivityModel> activities = [];

    // Recent Books
    final books = await _firestore
        .collection("books")
        .orderBy("createdAt", descending: true)
        .limit(5)
        .get();

    for (final doc in books.docs) {
      final data = doc.data();

      activities.add(
        ActivityModel(
          title: data["title"] ?? "Book",
          subtitle: "New book uploaded",
          time: (data["createdAt"] as Timestamp).toDate(),
          type: "book",
        ),
      );
    }

    // Recent Users
    final users = await _firestore
        .collection("users")
        .orderBy("createdAt", descending: true)
        .limit(5)
        .get();

    for (final doc in users.docs) {
      final data = doc.data();

      activities.add(
        ActivityModel(
          title: data["name"] ?? "User",
          subtitle: "New user registered",
          time: (data["createdAt"] as Timestamp).toDate(),
          type: "user",
        ),
      );
    }

    activities.sort(
          (a, b) => b.time.compareTo(a.time),
    );

    return activities.take(8).toList();
  }
}