import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_theme.dart';
import '../models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingPage({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          const Spacer(),

          Expanded(
            flex: 5,
            child: Image.asset(
              page.image,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: AppSizes.xl),

          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextTheme.lightTextTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSizes.md),

          Text(
            page.description,
            textAlign: TextAlign.center,
            style: AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}