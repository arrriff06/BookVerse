import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
class RecentBookTile extends StatelessWidget {
  final String title;
  final String author;

  const RecentBookTile({
    super.key,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(.12),
        child: const Icon(
          Icons.menu_book,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(author),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}