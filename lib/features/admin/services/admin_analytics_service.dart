import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAnalyticsService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Total Books
  static Future<int> totalBooks() async {
    final snapshot = await _firestore.collection('books').get();
    return snapshot.docs.length;
  }

  /// Total Users
  static Future<int> totalUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.length;
  }

  /// Featured Books
  static Future<int> featuredBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .where('featured', isEqualTo: true)
        .get();

    return snapshot.docs.length;
  }

  /// Trending Books
  static Future<int> trendingBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .where('trending', isEqualTo: true)
        .get();

    return snapshot.docs.length;
  }

  /// Total Downloads
  static Future<int> totalDownloads() async {
    final snapshot = await _firestore.collection('books').get();

    int total = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      total += data.containsKey('downloads')
          ? (data['downloads'] as num).toInt()
          : 0;
    }

    return total;
  }

  /// Total Readers
  static Future<int> totalReaders() async {
    final snapshot = await _firestore.collection('books').get();

    int total = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      total += data.containsKey('readers')
          ? (data['readers'] as num).toInt()
          : 0;
    }

    return total;
  }

  /// Total Categories


  /// Latest Books
  static Future<List<QueryDocumentSnapshot>> latestBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();

    return snapshot.docs;
  }
  static Future<int> totalCategories() async {
    final snapshot = await _firestore.collection('books').get();

    final categories = <String>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data.containsKey('category')) {
        categories.add(data['category']);
      }
    }

    return categories.length;
  }
  /// Most Downloaded Books
  static Future<List<QueryDocumentSnapshot>> topDownloadedBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .orderBy('downloads', descending: true)
        .limit(5)
        .get();

    return snapshot.docs;
  }

  /// Highest Rated Books
  static Future<List<QueryDocumentSnapshot>> topRatedBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .orderBy('rating', descending: true)
        .limit(5)
        .get();

    return snapshot.docs;
  }
}