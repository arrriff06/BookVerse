import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class RequestStatusDialog extends StatefulWidget {
  final String currentStatus;
  final ValueChanged<String> onSave;

  const RequestStatusDialog({
    super.key,
    required this.currentStatus,
    required this.onSave,
  });

  @override
  State<RequestStatusDialog> createState() =>
      _RequestStatusDialogState();
}

class _RequestStatusDialogState
    extends State<RequestStatusDialog> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  Widget buildOption(
      String value,
      String title,
      IconData icon,
      Color color,
      ) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedStatus,
      activeColor: AppColors.primary,
      onChanged: (value) {
        setState(() {
          selectedStatus = value!;
        });
      },
      title: Row(
        children: [

          Icon(
            icon,
            color: color,
          ),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: const Text(
        "Update Request Status",
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            buildOption(
              "pending",
              "Pending",
              Icons.schedule,
              Colors.orange,
            ),

            buildOption(
              "uploading",
              "Uploading",
              Icons.cloud_upload,
              Colors.blue,
            ),

            buildOption(
              "uploaded",
              "Uploaded",
              Icons.check_circle,
              Colors.green,
            ),

            buildOption(
              "rejected",
              "Rejected",
              Icons.cancel,
              Colors.red,
            ),
          ],
        ),
      ),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () {
            widget.onSave(selectedStatus);
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}