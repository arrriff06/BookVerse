import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.notifications;

    switch (notification.type) {
      case "request_uploaded":
        icon = Icons.menu_book;
        break;

      case "membership":
        icon = Icons.workspace_premium;
        break;

      case "announcement":
        icon = Icons.campaign;
        break;

      default:
        icon = Icons.notifications;
    }

    return Card(
      elevation: 1,
      margin:
      const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          AppColors.primary.withValues(
              alpha: .12),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(
              fontWeight:
              FontWeight.bold),
        ),
        subtitle: Text(notification.body),
        trailing: notification.isRead
            ? null
            : Container(
          width: 10,
          height: 10,
          decoration:
          const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}