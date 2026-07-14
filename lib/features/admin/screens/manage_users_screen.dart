import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/admin_user_service.dart';
import '../widgets/user_tile.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: AdminUserService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Users"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc =
              snapshot.data!.docs[index];

              final data =
              doc.data() as Map<String, dynamic>;

              return UserTile(
                user: data,

                onDelete: () async {
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        "Delete User?",
                      ),
                      content: const Text(
                        "This cannot be undone.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(
                                  context, false),
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(
                                  context, true),
                          child: const Text(
                            "Delete",
                          ),
                        ),
                      ],
                    ),
                  );

                  if (ok == true) {
                    await AdminUserService
                        .deleteUser(doc.id);
                  }
                },

                onChangeRole: () async {
                  final current =
                      data["role"] ?? "user";

                  await AdminUserService
                      .changeRole(
                    doc.id,
                    current == "admin"
                        ? "user"
                        : "admin",
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}