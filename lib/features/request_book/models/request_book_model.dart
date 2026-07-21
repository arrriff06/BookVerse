import 'package:cloud_firestore/cloud_firestore.dart';

class RequestBookModel {
  final String id;
  final String uid;
  final String userName;
  final String email;
  final String bookName;
  final String author;
  final String language;
  final String category;
  final String notes;
  final String status;
  final String bookId;
  final String feedback;
  final double rating;
  final Timestamp createdAt;
  final Timestamp? uploadedAt;

  const RequestBookModel({
    required this.id,
    required this.uid,
    required this.userName,
    required this.email,
    required this.bookName,
    required this.author,
    required this.language,
    required this.category,
    required this.notes,
    required this.status,
    required this.bookId,
    required this.feedback,
    required this.rating,
    required this.createdAt,
    this.uploadedAt,
  });

  factory RequestBookModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data = doc.data() as Map<String, dynamic>;

    return RequestBookModel(
      id: doc.id,
      uid: data["uid"] ?? "",
      userName: data["userName"] ?? "",
      email: data["email"] ?? "",
      bookName: data["bookName"] ?? "",
      author: data["author"] ?? "",
      language: data["language"] ?? "",
      category: data["category"] ?? "",
      notes: data["notes"] ?? "",
      status: data["status"] ?? "pending",
      bookId: data["bookId"] ?? "",
      feedback: data["feedback"] ?? "",
      rating: (data["rating"] ?? 0).toDouble(),
      createdAt: data["createdAt"] ?? Timestamp.now(),
      uploadedAt: data["uploadedAt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      "bookName": bookName,
      "author": author,
      "language": language,
      "category": category,
      "notes": notes,
      "status": status,
      "bookId": bookId,
      "feedback": feedback,
      "rating": rating,
      "createdAt": createdAt,
      "uploadedAt": uploadedAt,
    };
  }
}