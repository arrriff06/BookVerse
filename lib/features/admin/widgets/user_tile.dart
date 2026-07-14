import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onDelete;
  final VoidCallback onChangeRole;

  const UserTile({
    super.key,
    required this.user,
    required this.onDelete,
    required this.onChangeRole,
  });

  @override
  Widget build(BuildContext context) {
    final role = user["role"] ?? "user";
    final photoUrl = user["photoUrl"] ?? "";
    final membership = user["membership"] ?? "Free";

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage:
          photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
          child: photoUrl.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(
          user["name"] ?? "No Name",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user["email"] ?? ""),
            const SizedBox(height: 4),
            Text("Membership: $membership"),
            const SizedBox(height: 4),
            Text(
              "Role: ${role.toString().toUpperCase()}",
              style: TextStyle(
                color: role == "admin"
                    ? Colors.red
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "role") {
              onChangeRole();
            }

            if (value == "delete") {
              onDelete();
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: "role",
              child: Text(
                role == "admin"
                    ? "Make User"
                    : "Make Admin",
              ),
            ),
            const PopupMenuItem(
              value: "delete",
              child: Text("Delete User"),
            ),
          ],
        ),
      ),
    );
  }
}