import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../books/models/book_model.dart';
import '../../books/services/book_service.dart';
import '../../books/services/cloudinary_service.dart';
import '../../notifications/services/notification_service.dart';

class CompleteRequestUploadService {
  CompleteRequestUploadService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<void> uploadRequestedBook({
    required String requestId,
    required String uid,

    required File cover,
    required String pdfUrl,

    required String title,
    required String author,
    required String description,
    required String category,
    required String language,
    required String publisher,

    required int pages,

    bool featured = false,
    bool trending = false,
  }) async {
    try {
      //------------------------------------------
      // Upload Cover to Cloudinary
      //------------------------------------------

      final coverUrl = await CloudinaryService.uploadImage(cover);

      if (coverUrl == null) {
        throw Exception("Cover upload failed.");
      }

      //------------------------------------------
      // Create Book
      //------------------------------------------

      final book = BookModel(
        id: "",
        title: title,
        author: author,
        description: description,
        category: category,
        coverImage: coverUrl,
        rating: 5.0,
        pages: pages,
        pdfUrl: pdfUrl,
        language: language,
        publisher: publisher,
        publishedDate: DateTime.now()
            .toIso8601String()
            .split("T")
            .first,
        publishedYear: DateTime.now().year.toString(),
        featured: featured,
        trending: trending,
        downloads: 0,
        readers: 0,
      );

      //------------------------------------------
      // Upload Book
      //------------------------------------------

      final bookId = await BookService.uploadBook(book);

      //------------------------------------------
      // Update Request
      //------------------------------------------

      await _firestore
          .collection("request_books")
          .doc(requestId)
          .update({
        "status": "uploaded",
        "bookUploaded": true,
        "bookId": bookId,
        "uploadedAt": FieldValue.serverTimestamp(),
        "coverImage": coverUrl,
        "pdfUrl": pdfUrl,
      });

      //------------------------------------------
      // Notify User
      //------------------------------------------

      await NotificationService.sendNotification(
        uid: uid,
        title: "📚 Your requested book is ready!",
        body:
        "Your requested book \"$title\" has been uploaded successfully.",
        type: "request_uploaded",
      );
    } catch (e) {
      throw Exception("Failed to upload requested book: $e");
    }
  }
}