import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  String get subtitle {
    switch (title) {
      case "Upload Book":
        return "Add new books";
      case "Manage Books":
        return "Edit & delete books";
      case "Manage Users":
        return "Roles & accounts";
      case "Categories":
        return "Organize books";
      case "Analytics":
        return "View statistics";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(.18),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: color.withOpacity(.25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CircleAvatar(
                  radius: 24,
                  backgroundColor: color.withOpacity(.15),
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),

                const Spacer(),

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),

                const Spacer(),

                Row(
                  children: [

                    Text(
                      "Open",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}