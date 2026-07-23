import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  StorageService._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static const Uuid _uuid = Uuid();

  /// Upload Book Cover Image
  static Future<String> uploadBookCover(File image) async {
    try {
      final fileName = "${_uuid.v4()}.jpg";

      final ref = _storage
          .ref()
          .child("book_covers")
          .child(fileName);

      await ref.putFile(image);

      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload cover image: $e");
    }
  }


  /// Delete Book Cover
  static Future<void> deleteBookCover(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (_) {
      // Ignore if file doesn't exist
    }
  }
  /// Upload Book PDF
  static Future<String> uploadBookPdf(File pdf) async {
    try {
      final fileName = "${_uuid.v4()}.pdf";

      final ref = _storage
          .ref()
          .child("book_pdfs")
          .child(fileName);

      await ref.putFile(pdf);

      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload PDF: $e");
    }
  }
  /// Delete PDF
  static Future<void> deleteBookPdf(String pdfUrl) async {
    try {
      await _storage.refFromURL(pdfUrl).delete();
    } catch (_) {}
  }
}