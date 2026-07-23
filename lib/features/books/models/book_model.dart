import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;
  final String coverImage;

  // Existing
  final double rating;
  final int pages;

  // Reader
  final String pdfUrl;
  final String language;
  final String publisher;
  final String publishedDate;
  final String publishedYear;

  // Library
  final bool featured;
  final bool trending;
  final int downloads;
  final int readers;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.coverImage,
    required this.rating,
    required this.pages,
    required this.pdfUrl,
    required this.language,
    required this.publisher,
    required this.publishedDate,
    required this.publishedYear,
    required this.featured,
    required this.trending,
    required this.downloads,
    required this.readers,
  });

  factory BookModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BookModel(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      coverImage: data['coverImage'] ?? '',

      rating: (data['rating'] ?? 0).toDouble(),
      pages: (data['pages'] ?? 0) as int,

      pdfUrl: data['pdfUrl'] ?? '',
      language: data['language'] ?? 'English',
      publisher: data['publisher'] ?? '',
      publishedDate: data['publishedDate'] ?? '',
      publishedYear: data['publishedYear'] ?? '',

      featured: data['featured'] ?? false,
      trending: data['trending'] ?? false,
      downloads: data['downloads'] ?? 0,
      readers: data['readers'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'category': category,
      'coverImage': coverImage,

      'rating': rating,
      'pages': pages,

      'pdfUrl': pdfUrl,
      'language': language,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'publishedYear': publishedYear,

      'featured': featured,
      'trending': trending,
      'downloads': downloads,
      'readers': readers,

      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}