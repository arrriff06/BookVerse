import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookverse/features/books/models/book_model.dart';
class WishlistService {
  WishlistService._();

  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  /// Add Book
  static Future<void> addToWishlist(String bookId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(bookId)
        .set({
      'bookId': bookId,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove Book
  static Future<void> removeFromWishlist(String bookId) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(bookId)
        .delete();
  }
  static Stream<List<BookModel>> getWishlistBooks() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('wishlist')
        .snapshots()
        .asyncMap((snapshot) async {
      List<BookModel> books = [];

      for (final doc in snapshot.docs) {
        final bookId = doc.id;

        final bookDoc = await FirebaseFirestore.instance
            .collection('books')
            .doc(bookId)
            .get();

        if (bookDoc.exists) {
          books.add(BookModel.fromFirestore(bookDoc));
        }
      }

      return books;
    });
  }

  /// Check if book exists
  static Stream<bool> isWishlisted(String bookId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(bookId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  /// Wishlist IDs
  static Stream<List<String>> wishlistIds() {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((e) => e.id)
          .toList(),
    );
  }
}