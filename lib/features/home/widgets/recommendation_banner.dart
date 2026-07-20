import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RecommendationBanner extends StatelessWidget {
  const RecommendationBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            Color(0xffA91E4A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [

                  const Text(
                    "Today's Pick",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Discover your next\nfavorite book.",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor:
                      AppColors.primary,
                    ),
                    onPressed: () {},

                    child: const Text(
                      "Explore",
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 90,
            ),
          ],
        ),
      ),
    );
  }
}