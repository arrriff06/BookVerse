import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bookverse/features/books/models/book_model.dart';
import 'package:bookverse/features/books/services/book_service.dart';

final booksProvider = FutureProvider<List<BookModel>>((ref) async {
  return BookService.getBooks();
});

final featuredBooksProvider = FutureProvider<List<BookModel>>((ref) async {
  return BookService.getFeaturedBooks();
});

final trendingBooksProvider = FutureProvider<List<BookModel>>((ref) async {
  return BookService.getTrendingBooks();
});

final singleBookProvider =
FutureProvider.family<BookModel, String>((ref, bookId) async {
  return BookService.getBook(bookId);
});

final searchQueryProvider = StateProvider<String>((ref) => "");

final filteredBooksProvider = FutureProvider<List<BookModel>>((ref) async {
  final books = await ref.watch(booksProvider.future);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return books;

  return books.where((book) {
    return book.title.toLowerCase().contains(query) ||
        book.author.toLowerCase().contains(query) ||
        book.category.toLowerCase().contains(query);
  }).toList();
});