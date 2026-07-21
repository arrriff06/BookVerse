import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RequestSuccessDialog extends StatelessWidget {
  const RequestSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 60,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              "Request Submitted",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Thank you for requesting a book.\n\n"
                  "We'll review your request and, if the book can be legally provided, it is usually uploaded within 24 hours.\n\n"
                  "You'll receive a notification as soon as it becomes available.",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.6,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Awesome"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}