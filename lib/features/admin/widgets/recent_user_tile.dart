import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
class RecentUserTile extends StatelessWidget {
  final String name;
  final String role;

  const RecentUserTile({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(.12),
        child: const Icon(
          Icons.person,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(role),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}