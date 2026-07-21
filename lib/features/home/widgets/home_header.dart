import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onSearch;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onSearch,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        10,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          //------------------------------------------------
          // Logo + Search
          //------------------------------------------------

          Row(
            children: [

              const Expanded(
                child: Text(
                  "BookVerse",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -.8,
                  ),
                ),
              ),

              Material(
                color: Colors.white,
                elevation: 8,
                shadowColor:
                Colors.black.withValues(alpha: .08),
                borderRadius:
                BorderRadius.circular(18),
                child: InkWell(
                  borderRadius:
                  BorderRadius.circular(18),
                  onTap: onSearch,
                  child: const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          //------------------------------------------------
          // Greeting
          //------------------------------------------------

          Text(
            _greeting(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: [

              Expanded(
                child: Text(
                  "$userName 👋",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            "What would you like to read today?",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}