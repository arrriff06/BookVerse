import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/admin_user_service.dart';
import '../widgets/user_card.dart';
import 'user_details_screen.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() =>
      _ManageUsersScreenState();
}

class _ManageUsersScreenState
    extends State<ManageUsersScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Users"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: AdminUserService.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Users Found"),
                  );
                }

                List<UserModel> users =
                snapshot.data!;

                if (search.isNotEmpty) {
                  users = users.where((user) {
                    return user.name
                        .toLowerCase()
                        .contains(search) ||
                        user.email
                            .toLowerCase()
                            .contains(search);
                  }).toList();
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return UserCard(
                      user: user,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UserDetailsScreen(
                                  user: user,
                                ),
                          ),
                        );
                      },

                      onDelete: () async {
                        await AdminUserService
                            .deleteUser(user.id);
                      },

                      onToggleBlock: () async {
                        await AdminUserService
                            .blockUser(
                          user.id,
                          !user.blocked,
                        );
                      },

                      onToggleRole: () async {
                        await AdminUserService
                            .changeRole(
                          user.id,
                          user.role == "admin"
                              ? "user"
                              : "admin",
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}