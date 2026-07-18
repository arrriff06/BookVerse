import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../books/models/book_model.dart';

class LibraryService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// Add book to library
  static Future<void> addToLibrary(BookModel book) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .doc(book.id)
        .set({
      "addedAt": FieldValue.serverTimestamp(),
      "status": "Want to Read",
      "progress": 0,
      "currentPage": 0,
      "lastRead": FieldValue.serverTimestamp(),
    });
  }

  /// Remove book
  static Future<void> removeFromLibrary(
      String bookId,
      ) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .doc(bookId)
        .delete();
  }

  /// Check if already saved
  static Stream<bool> isInLibrary(
      String bookId,
      ) {
    final user = _auth.currentUser;

    if (user == null) {
      return Stream.value(false);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .doc(bookId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  /// Get all library books
  static Stream<List<BookModel>> getLibraryBooks() {
    final user = _auth.currentUser;

    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .snapshots()
        .asyncMap((snapshot) async {
      List<BookModel> books = [];

      for (final doc in snapshot.docs) {
        final bookDoc = await _firestore
            .collection('books')
            .doc(doc.id)
            .get();

        if (bookDoc.exists) {
          books.add(BookModel.fromFirestore(bookDoc));
        }
      }

      return books;
    });
  }

  /// Update reading progress
  static Future<void> updateProgress({
    required String bookId,
    required int currentPage,
    required int progress,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .doc(bookId)
        .update({
      "currentPage": currentPage,
      "progress": progress,
      "lastRead": FieldValue.serverTimestamp(),
    });
  }
}