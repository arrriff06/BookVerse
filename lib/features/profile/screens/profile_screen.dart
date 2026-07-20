import 'package:flutter/material.dart';

import '../../developer/screens/developer_screen.dart';
import '../services/profile_service.dart';
import '../widgets/profile_header.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService.getUserProfile();
  }

  void _refresh() {
    setState(() {
      _profileFuture = ProfileService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return const Center(
              child: Text("Profile not found"),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ProfileHeader(
                  name: data["name"] ?? "",
                  email: data["email"] ?? "",
                  imageUrl: data["photoUrl"],
                ),

                const SizedBox(height: 40),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Profile"),
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );

                      if (updated == true) {
                        _refresh();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

                _profileTile(
                  icon: Icons.email_outlined,
                  title: "Email",
                  value: data["email"] ?? "Not available",
                ),

                _profileTile(
                  icon: Icons.phone_outlined,
                  title: "Phone",
                  value: data["phone"]?.toString().isEmpty ?? true
                      ? "Not added"
                      : data["phone"],
                ),
                _profileTile(
                  icon: Icons.admin_panel_settings_outlined,
                  title: "Role",
                  value: data["role"] ?? "User",
                ),

                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.12),
                      child: Icon(
                        Icons.code,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: const Text(
                      "About Developer",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Meet the creator of BookVerse",
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeveloperScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await ProfileService.logout();

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/login",
                              (route) => false,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}