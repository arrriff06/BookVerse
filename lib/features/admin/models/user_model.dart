import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String phone;
  final String role;
  final bool blocked;
  final Timestamp? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.role,
    required this.blocked,
    this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: doc.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      photo: data["photo"] ?? "",
      phone: data["phone"] ?? "",
      role: data["role"] ?? "user",
      blocked: data["blocked"] ?? false,
      createdAt: data["createdAt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "photo": photo,
      "phone": phone,
      "role": role,
      "blocked": blocked,
      "createdAt": createdAt,
    };
  }
}