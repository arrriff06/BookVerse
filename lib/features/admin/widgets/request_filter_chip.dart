import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RequestFilterChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const RequestFilterChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}