import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/models/book_model.dart';
import '../services/library_service.dart';

/// Streams all books saved in the user's library
final libraryProvider =
StreamProvider<List<BookModel>>((ref) {
  return LibraryService.getLibraryBooks();
});