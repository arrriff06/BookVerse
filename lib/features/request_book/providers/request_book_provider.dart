import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/request_book_model.dart';
import '../services/request_book_service.dart';

/// Stream of current user's requests
final myRequestsProvider =
StreamProvider<List<RequestBookModel>>((ref) {
  return RequestBookService.getMyRequests();
});

/// Loading state while submitting a request
final requestLoadingProvider =
StateProvider<bool>((ref) => false);