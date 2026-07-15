import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/activity_model.dart';

class ActivityTile extends StatelessWidget {
  final ActivityModel activity;

  const ActivityTile({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon =
    activity.type == "book"
        ? Icons.menu_book
        : Icons.person;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
        AppColors.primary.withOpacity(.12),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
      title: Text(
        activity.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(activity.subtitle),
      trailing: Text(
        _timeAgo(activity.time),
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m";
    if (diff.inHours < 24) return "${diff.inHours}h";
    return "${diff.inDays}d";
  }
}