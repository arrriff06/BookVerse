import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class AdminCategoryService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static const String _collection = "categories";

  /// Get all categories
  static Stream<List<CategoryModel>> getCategories() {
    return _firestore
        .collection(_collection)
        .orderBy("name")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList(),
    );
  }

  /// Add Category
  static Future<void> addCategory(
      CategoryModel category,
      ) async {
    await _firestore
        .collection(_collection)
        .add(category.toMap());
  }

  /// Update Category
  static Future<void> updateCategory(
      String id,
      CategoryModel category,
      ) async {
    await _firestore
        .collection(_collection)
        .doc(id)
        .update(category.toMap());
  }

  /// Delete Category
  static Future<void> deleteCategory(
      String id,
      ) async {
    await _firestore
        .collection(_collection)
        .doc(id)
        .delete();
  }

  /// Get single category
  static Future<CategoryModel> getCategory(
      String id,
      ) async {
    final doc = await _firestore
        .collection(_collection)
        .doc(id)
        .get();

    return CategoryModel.fromFirestore(doc);
  }

  /// Update book count
  static Future<void> updateBookCount(
      String categoryName,
      ) async {
    final books = await _firestore
        .collection("books")
        .where("category", isEqualTo: categoryName)
        .get();

    final category = await _firestore
        .collection(_collection)
        .where("name", isEqualTo: categoryName)
        .limit(1)
        .get();

    if (category.docs.isNotEmpty) {
      await category.docs.first.reference.update({
        "bookCount": books.docs.length,
      });
    }
  }
}