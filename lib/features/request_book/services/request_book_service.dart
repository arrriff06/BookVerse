import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/request_book_model.dart';

class RequestBookService {
  RequestBookService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// Submit Request
  static Future<void> submitRequest({
    required String bookName,
    required String author,
    required String language,
    required String category,
    required String notes,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in.");
    }

    final userDoc = await _firestore
        .collection("users")
        .doc(user.uid)
        .get();

    final data = userDoc.data() ?? {};

    await _firestore.collection("request_books").add({
      "uid": user.uid,
      "userName": data["name"] ?? "",
      "email": data["email"] ?? "",
      "bookName": bookName,
      "author": author,
      "language": language,
      "category": category,
      "notes": notes,
      "status": "pending",
      "bookId": "",
      "feedback": "",
      "rating": 0,
      "createdAt": FieldValue.serverTimestamp(),
      "uploadedAt": null,
    });
  }

  /// Current User Requests
  static Stream<List<RequestBookModel>> getMyRequests() {
    final user = _auth.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("request_books")
        .where("uid", isEqualTo: user.uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) =>
            RequestBookModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  /// Update Feedback
  static Future<void> submitFeedback({
    required String requestId,
    required String feedback,
    required double rating,
  }) async {
    await _firestore
        .collection("request_books")
        .doc(requestId)
        .update({
      "feedback": feedback,
      "rating": rating,
    });
  }
}