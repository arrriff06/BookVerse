import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notifications/services/notification_service.dart';
import '../../request_book/models/request_book_model.dart';

class AdminRequestService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  //------------------------------------------------------
  // Streams
  //------------------------------------------------------

  static Stream<List<RequestBookModel>> getRequests() {
    return _firestore
        .collection("request_books")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map(RequestBookModel.fromFirestore)
        .toList());
  }

  static Stream<List<RequestBookModel>> getPendingRequests() {
    return _streamByStatus("pending");
  }

  static Stream<List<RequestBookModel>> getUploadingRequests() {
    return _streamByStatus("uploading");
  }

  static Stream<List<RequestBookModel>> getUploadedRequests() {
    return _streamByStatus("uploaded");
  }

  static Stream<List<RequestBookModel>> getRejectedRequests() {
    return _streamByStatus("rejected");
  }

  static Stream<List<RequestBookModel>> _streamByStatus(
      String status) {
    return _firestore
        .collection("request_books")
        .where("status", isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map(RequestBookModel.fromFirestore)
        .toList());
  }

  //------------------------------------------------------
  // Uploading
  //------------------------------------------------------

  static Future<void> setUploading({
    required String requestId,
    required String uid,
    required String bookName,
  }) async {
    await _firestore
        .collection("request_books")
        .doc(requestId)
        .update({
      "status": "uploading",
    });

    await NotificationService.sendNotification(
      uid: uid,
      title: "We're preparing your book 📚",
      body:
      "$bookName is currently being uploaded by our admin.",
      type: "uploading",
    );
  }

  //------------------------------------------------------
  // Uploaded
  //------------------------------------------------------

  static Future<void> setUploaded({
    required String requestId,
    required String uid,
    required String bookId,
    required String bookName,
  }) async {
    await _firestore
        .collection("request_books")
        .doc(requestId)
        .update({
      "status": "uploaded",
      "bookId": bookId,
      "uploadedAt": FieldValue.serverTimestamp(),
    });

    await NotificationService.sendNotification(
      uid: uid,
      title: "Book Uploaded 🎉",
      body:
      "$bookName is now available to read.",
      type: "uploaded",
    );
  }

  //------------------------------------------------------
  // Reject
  //------------------------------------------------------

  static Future<void> rejectRequest({
    required String requestId,
    required String uid,
    required String reason,
    required String bookName,
  }) async {
    await _firestore
        .collection("request_books")
        .doc(requestId)
        .update({
      "status": "rejected",
      "rejectReason": reason,
    });

    await NotificationService.sendNotification(
      uid: uid,
      title: "Request Rejected",
      body:
      "$bookName couldn't be uploaded.\nReason: $reason",
      type: "rejected",
    );
  }
}