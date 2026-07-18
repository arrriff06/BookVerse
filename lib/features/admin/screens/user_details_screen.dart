import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/admin_user_service.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 60,
              backgroundImage:
              user.photo.isNotEmpty
                  ? NetworkImage(user.photo)
                  : null,
              child: user.photo.isEmpty
                  ? const Icon(
                Icons.person,
                size: 60,
              )
                  : null,
            ),

            const SizedBox(height: 20),

            Text(
              user.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              user.email,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    _infoTile(
                      Icons.phone,
                      "Phone",
                      user.phone.isEmpty
                          ? "Not Available"
                          : user.phone,
                    ),

                    const Divider(),

                    _infoTile(
                      Icons.admin_panel_settings,
                      "Role",
                      user.role.toUpperCase(),
                    ),

                    const Divider(),

                    _infoTile(
                      Icons.block,
                      "Status",
                      user.blocked
                          ? "Blocked"
                          : "Active",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(
                  user.blocked
                      ? Icons.lock_open
                      : Icons.block,
                ),
                label: Text(
                  user.blocked
                      ? "Unblock User"
                      : "Block User",
                ),
                onPressed: () async {
                  await AdminUserService.blockUser(
                    user.id,
                    !user.blocked,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.admin_panel_settings,
                ),
                label: Text(
                  user.role == "admin"
                      ? "Make User"
                      : "Make Admin",
                ),
                onPressed: () async {
                  await AdminUserService.changeRole(
                    user.id,
                    user.role == "admin"
                        ? "user"
                        : "admin",
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("Delete User"),
                onPressed: () async {
                  final delete = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete User"),
                      content: const Text(
                        "Are you sure you want to permanently delete this user?",
                      ),
                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancel"),
                        ),

                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (delete == true) {
                    await AdminUserService.deleteUser(
                      user.id,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
      IconData icon,
      String title,
      String value,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}