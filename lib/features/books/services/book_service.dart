import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book_model.dart';

class BookService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Upload Book
  static Future<void> uploadBook(BookModel book) async {
    await _firestore.collection('books').add(book.toMap());
  }

  /// Update Book
  static Future<void> updateBook(
      String bookId,
      BookModel book,
      ) async {
    await _firestore
        .collection('books')
        .doc(bookId)
        .update(book.toMap());
  }

  /// Delete Book
  static Future<void> deleteBook(String bookId) async {
    await _firestore
        .collection('books')
        .doc(bookId)
        .delete();
  }

  /// Get All Books
  static Future<List<BookModel>> getBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .orderBy('title')
        .get();

    return snapshot.docs
        .map((e) => BookModel.fromFirestore(e))
        .toList();
  }

  /// Featured Books
  static Future<List<BookModel>> getFeaturedBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .where('featured', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => BookModel.fromFirestore(e))
        .toList();
  }

  /// Trending Books
  static Future<List<BookModel>> getTrendingBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .where('trending', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((e) => BookModel.fromFirestore(e))
        .toList();
  }

  /// Single Book
  static Future<BookModel> getBook(String id) async {
    final doc = await _firestore
        .collection('books')
        .doc(id)
        .get();

    return BookModel.fromFirestore(doc);
  }
}