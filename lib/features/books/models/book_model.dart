import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String category;
  final String coverImage;
  final double price;
  final double rating;
  final int pages;


  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.coverImage,
    required this.price,
    required this.rating,
    required this.pages,
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
      price: (data['price'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      pages: data['pages'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "author": author,
      "description": description,
      "category": category,
      "coverImage": coverImage,
      "price": price,
      "rating": rating,
      "pages": pages,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }
}