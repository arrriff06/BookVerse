import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final int bookCount;
  final Timestamp? createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.bookCount,
    this.createdAt,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return CategoryModel(
      id: doc.id,
      name: data["name"] ?? "",
      image: data["image"] ?? "",
      bookCount: data["bookCount"] ?? 0,
      createdAt: data["createdAt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "bookCount": bookCount,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    int? bookCount,
    Timestamp? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      bookCount: bookCount ?? this.bookCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}