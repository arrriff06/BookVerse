import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/setting_model.dart';

class AdminSettingsService {
  AdminSettingsService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static DocumentReference get _doc =>
      _firestore.collection("settings").doc("app");

  static Future<SettingModel?> loadSettings() async {
    final doc = await _doc.get();

    if (!doc.exists) return null;

    return SettingModel.fromMap(
      doc.data() as Map<String, dynamic>,
    );
  }

  static Future<void> saveSettings(
      SettingModel model) async {
    await _doc.set(
      model.toMap(),
      SetOptions(merge: true),
    );
  }
}