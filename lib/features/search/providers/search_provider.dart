import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/models/book_model.dart';
import '../services/search_service.dart';

/// Search text
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Search Results
final searchResultsProvider =
FutureProvider<List<BookModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);

  return SearchService.searchBooks(query);
});