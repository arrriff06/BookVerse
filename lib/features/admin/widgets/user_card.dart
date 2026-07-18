import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleBlock;
  final VoidCallback onToggleRole;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDelete,
    required this.onToggleBlock,
    required this.onToggleRole,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          radius: 28,
          backgroundImage:
          user.photo.isNotEmpty ? NetworkImage(user.photo) : null,
          child: user.photo.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),

        title: Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),

            const SizedBox(height: 6),

            Wrap(
              spacing: 8,
              children: [

                Chip(
                  backgroundColor:
                  user.role == "admin"
                      ? Colors.green.shade100
                      : Colors.blue.shade100,
                  label: Text(
                    user.role.toUpperCase(),
                  ),
                ),

                if (user.blocked)
                  Chip(
                    backgroundColor: Colors.red.shade100,
                    label: const Text("BLOCKED"),
                  ),
              ],
            ),
          ],
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case "role":
                onToggleRole();
                break;

              case "block":
                onToggleBlock();
                break;

              case "delete":
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [

            PopupMenuItem(
              value: "role",
              child: Text(
                user.role == "admin"
                    ? "Make User"
                    : "Make Admin",
              ),
            ),

            PopupMenuItem(
              value: "block",
              child: Text(
                user.blocked
                    ? "Unblock User"
                    : "Block User",
              ),
            ),

            const PopupMenuDivider(),

            const PopupMenuItem(
              value: "delete",
              child: Text(
                "Delete User",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}