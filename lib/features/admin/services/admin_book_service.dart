import 'package:cloud_firestore/cloud_firestore.dart';

class AdminBookService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<int> totalBooks() async {
    final snapshot =
    await _firestore.collection('books').get();

    return snapshot.docs.length;
  }
  static Stream<int> pendingRequests() {
    return FirebaseFirestore.instance
        .collection("request_books")
        .where("status", isEqualTo: "pending")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Future<int> totalUsers() async {
    final snapshot =
    await _firestore.collection('users').get();

    return snapshot.docs.length;
  }

  static Future<int> totalWishlist() async {
    final users =
    await _firestore.collection('users').get();

    int total = 0;

    for (var user in users.docs) {
      final wishlist = await user.reference
          .collection('wishlist')
          .get();

      total += wishlist.docs.length;
    }

    return total;
  }
  static Stream<QuerySnapshot> recentBooks() {
    return FirebaseFirestore.instance
        .collection("books")
        .orderBy("createdAt", descending: true)
        .limit(5)
        .snapshots();
  }

  static Stream<QuerySnapshot> recentUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("createdAt", descending: true)
        .limit(5)
        .snapshots();
  }

  static Future<int> totalLibrary() async {
    final users =
    await _firestore.collection('users').get();

    int total = 0;

    for (var user in users.docs) {
      final library = await user.reference
          .collection('library')
          .get();

      total += library.docs.length;
    }

    return total;
  }
}
