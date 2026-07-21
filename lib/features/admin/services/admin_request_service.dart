import 'package:cloud_firestore/cloud_firestore.dart';

import '../../request_book/models/request_book_model.dart';

class AdminRequestService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// All Requests
  static Stream<List<RequestBookModel>>
  getRequests() {
    return _firestore
        .collection("request_books")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) =>
            RequestBookModel.fromFirestore(e),
      )
          .toList(),
    );
  }

  /// Pending
  static Stream<List<RequestBookModel>>
  getPendingRequests() {
    return _firestore
        .collection("request_books")
        .where("status", isEqualTo: "pending")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) =>
            RequestBookModel.fromFirestore(e),
      )
          .toList(),
    );
  }

  /// Uploading
  static Stream<List<RequestBookModel>>
  getUploadingRequests() {
    return _firestore
        .collection("request_books")
        .where("status", isEqualTo: "uploading")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) =>
            RequestBookModel.fromFirestore(e),
      )
          .toList(),
    );
  }

  /// Uploaded
  static Stream<List<RequestBookModel>>
  getUploadedRequests() {
    return _firestore
        .collection("request_books")
        .where("status", isEqualTo: "uploaded")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) =>
            RequestBookModel.fromFirestore(e),
      )
          .toList(),
    );
  }

  /// Reject
  static Future<void> rejectRequest(
      String id) async {
    await _firestore
        .collection("request_books")
        .doc(id)
        .update({
      "status": "rejected",
    });
  }

  /// Uploading
  static Future<void> setUploading(
      String id) async {
    await _firestore
        .collection("request_books")
        .doc(id)
        .update({
      "status": "uploading",
    });
  }

  /// Uploaded
  static Future<void> setUploaded(
      String id) async {
    await _firestore
        .collection("request_books")
        .doc(id)
        .update({
      "status": "uploaded",
    });
  }
}