import 'package:flutter/material.dart';

class SettingTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const SettingTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}