import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book_model.dart';

class BookService {
  BookService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Upload Book
  static Future<String> uploadBook(BookModel book) async {
    final doc = _firestore.collection("books").doc();

    await doc.set({
      ...book.toMap(),
      "id": doc.id,
    });

    return doc.id;
  }

  /// Update Book
  static Future<void> updateBook(
      String bookId,
      BookModel book,
      ) async {
    await _firestore
        .collection("books")
        .doc(bookId)
        .update(book.toMap());
  }

  /// Delete Book
  static Future<void> deleteBook(
      String bookId,
      ) async {
    await _firestore
        .collection("books")
        .doc(bookId)
        .delete();
  }

  /// Get All Books
  static Future<List<BookModel>> getBooks() async {
    final snapshot = await _firestore
        .collection("books")
        .orderBy("title")
        .get();

    return snapshot.docs
        .map(BookModel.fromFirestore)
        .toList();
  }

  /// Featured Books
  static Future<List<BookModel>>
  getFeaturedBooks() async {
    final snapshot = await _firestore
        .collection("books")
        .where("featured", isEqualTo: true)
        .get();

    return snapshot.docs
        .map(BookModel.fromFirestore)
        .toList();
  }

  /// Trending Books
  static Future<List<BookModel>>
  getTrendingBooks() async {
    final snapshot = await _firestore
        .collection("books")
        .where("trending", isEqualTo: true)
        .get();

    return snapshot.docs
        .map(BookModel.fromFirestore)
        .toList();
  }

  /// Single Book
  static Future<BookModel> getBook(
      String id,
      ) async {
    final doc = await _firestore
        .collection("books")
        .doc(id)
        .get();

    if (!doc.exists) {
      throw Exception("Book not found.");
    }

    return BookModel.fromFirestore(doc);
  }

  /// Recently Added
  static Future<List<BookModel>>
  getRecentlyAddedBooks() async {
    final snapshot = await _firestore
        .collection("books")
        .orderBy("createdAt", descending: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map(BookModel.fromFirestore)
        .toList();
  }

  /// Search Books
  static Future<List<BookModel>> searchBooks(
      String keyword,
      ) async {
    final snapshot = await _firestore
        .collection("books")
        .orderBy("title")
        .startAt([keyword]).endAt(
      ['$keyword\uf8ff'],
    )
        .get();

    return snapshot.docs
        .map(BookModel.fromFirestore)
        .toList();
  }
}