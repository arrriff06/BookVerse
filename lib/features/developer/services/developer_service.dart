import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/developer_model.dart';

class DeveloperService {
  DeveloperService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static DocumentReference get _doc =>
      _firestore.collection("settings").doc("developer");

  static Future<DeveloperModel?> loadDeveloper() async {
    final doc = await _doc.get();

    if (!doc.exists) {
      return null;
    }

    return DeveloperModel.fromMap(
      doc.data() as Map<String, dynamic>,
    );
  }

  static Future<void> saveDeveloper(
      DeveloperModel model) async {
    await _doc.set(
      model.toMap(),
      SetOptions(merge: true),
    );
  }
}