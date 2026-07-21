import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;
    IconData icon;
    String text;

    switch (status.toLowerCase()) {
      case "uploaded":
        background = Colors.green.shade100;
        foreground = Colors.green.shade800;
        icon = Icons.check_circle_rounded;
        text = "Uploaded";
        break;

      case "rejected":
        background = Colors.red.shade100;
        foreground = Colors.red.shade700;
        icon = Icons.cancel_rounded;
        text = "Rejected";
        break;

      case "uploading":
        background = Colors.blue.shade100;
        foreground = Colors.blue.shade700;
        icon = Icons.cloud_upload_rounded;
        text = "Uploading";
        break;

      default:
        background = Colors.orange.shade100;
        foreground = Colors.orange.shade800;
        icon = Icons.schedule_rounded;
        text = "Pending";
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: foreground,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}