import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        child: loading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : const Text(
          "Save Changes",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}