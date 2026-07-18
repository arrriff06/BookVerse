import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/models/book_model.dart';
import '../services/wishlist_service.dart';

final wishlistProvider =
StreamProvider<List<BookModel>>((ref) {
  return WishlistService.getWishlistBooks();
});