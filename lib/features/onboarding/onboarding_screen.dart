import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/services/onboarding_service.dart';
import '../auth/login_screen.dart';
import 'models/onboarding_data.dart';
import 'widgets/onboarding_buttons.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  bool get _isLastPage => _currentPage == onboardingPages.length - 1;

  Future<void> _nextPage() async {
    if (_isLastPage) {
      // Save onboarding completed
      await OnboardingService.completeOnboarding();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } else {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _skip() async {
    // Save onboarding completed
    await OnboardingService.completeOnboarding();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    page: onboardingPages[index],
                  );
                },
              ),
            ),

            const SizedBox(height: AppSizes.md),

            PageIndicator(
              currentPage: _currentPage,
              pageCount: onboardingPages.length,
            ),

            const SizedBox(height: AppSizes.lg),

            OnboardingButtons(
              isLastPage: _isLastPage,
              onNext: _nextPage,
              onSkip: _skip,
            ),

            const SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}