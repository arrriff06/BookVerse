import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book_model.dart';

class BookService {
  BookService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Upload Book
  static Future<void> uploadBook(BookModel book) async {
    await _firestore
        .collection('books')
        .add(book.toMap());
  }

  /// Get All Books
  static Stream<QuerySnapshot> getBooks() {
    return _firestore
        .collection('books')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Update Book
  static Future<void> updateBook({
    required String bookId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection('books')
        .doc(bookId)
        .update(data);
  }

  /// Delete Book
  static Future<void> deleteBook(String bookId) async {
    await _firestore
        .collection('books')
        .doc(bookId)
        .delete();
  }

  /// Get Single Book
  static Future<DocumentSnapshot> getBook(String bookId) async {
    return await _firestore
        .collection('books')
        .doc(bookId)
        .get();
  }
}