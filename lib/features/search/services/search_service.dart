import 'package:cloud_firestore/cloud_firestore.dart';

import '../../books/models/book_model.dart';

class SearchService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<List<BookModel>> searchBooks(String query) async {
    final snapshot = await _firestore.collection('books').get();

    final books = snapshot.docs
        .map((doc) => BookModel.fromFirestore(doc))
        .toList();

    if (query.trim().isEmpty) {
      return books;
    }

    final search = query.toLowerCase();

    return books.where((book) {
      return book.title.toLowerCase().contains(search) ||
          book.author.toLowerCase().contains(search) ||
          book.category.toLowerCase().contains(search) ||
          book.publisher.toLowerCase().contains(search) ||
          book.language.toLowerCase().contains(search);
    }).toList();
  }
}