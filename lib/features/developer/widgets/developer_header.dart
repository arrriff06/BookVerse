import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/developer_model.dart';

class DeveloperHeader extends StatelessWidget {
  final DeveloperModel developer;

  const DeveloperHeader({
    super.key,
    required this.developer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 15),

          CircleAvatar(
            radius: 75,
            backgroundColor: Colors.white,
            backgroundImage: developer.photo.isNotEmpty
                ? NetworkImage(developer.photo)
                : const AssetImage(
              "assets/developer/arif.jpg",
            ) as ImageProvider,
          ),

          const SizedBox(height: 20),

          Text(
            developer.name.isEmpty
                ? "ARIF HOSSAIN"
                : developer.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            developer.designation.isEmpty
                ? "Software Developer"
                : developer.designation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "BCA Student • Brainware University",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 25),

          const Divider(),
        ],
      ),
    );
  }
}