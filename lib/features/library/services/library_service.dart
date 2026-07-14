import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LibraryService {
  LibraryService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  /// Add Book
  static Future<void> addBook(String bookId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('library')
        .doc(bookId)
        .set({
      'bookId': bookId,
      'status': 'reading',
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove Book
  static Future<void> removeBook(String bookId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('library')
        .doc(bookId)
        .delete();
  }

  /// Check if book exists
  static Stream<bool> isInLibrary(String bookId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('library')
        .doc(bookId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  /// Library IDs
  static Stream<List<String>> libraryIds() {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('library')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((e) => e.id)
          .toList(),
    );
  }
}