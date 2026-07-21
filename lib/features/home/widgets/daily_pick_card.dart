import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DailyPickCard extends StatelessWidget {
  const DailyPickCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xffC84B6A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .18),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  "✨ Daily Pick",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Read one chapter today.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Small progress every day creates extraordinary results.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .90),
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 22),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.auto_stories),
                  label: const Text(
                    "Continue Reading",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          const Icon(
            Icons.auto_stories_rounded,
            size: 95,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}