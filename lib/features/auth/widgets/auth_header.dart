import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: AppColors.primary,
            size: 45,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "BookVerse",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Read • Borrow • Buy Books",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 40),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Welcome Back 👋",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Continue with your Google account",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}