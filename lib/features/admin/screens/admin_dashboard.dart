import 'package:flutter/material.dart';

import '../services/admin_book_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/stat_card.dart';
import '../services/activity_service.dart';
import '../widgets/activity_tile.dart';
import 'admin_upload_book_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'categories_screen.dart';
import 'manage_books_screen.dart';
import 'manage_users_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/recent_book_tile.dart';
import '../widgets/recent_user_tile.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder(
        future: Future.wait([
          AdminBookService.totalBooks(),
          AdminBookService.totalUsers(),
          AdminBookService.totalWishlist(),
          AdminBookService.totalLibrary(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }

          final data = snapshot.data!;

          final books = data[0] as int;
          final users = data[1] as int;
          final wishlist = data[2] as int;
          final library = data[3] as int;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 55, 24, 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.accent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(.30),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "${_greeting()} 👋",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "BookVerse Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Manage your bookstore efficiently with real-time insights and powerful admin tools.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.15),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Column(
                                children: [

                                  Icon(
                                    Icons.admin_panel_settings_rounded,
                                    color: Colors.white,
                                  ),

                                  SizedBox(height: 8),

                                  Text(
                                    "Administrator",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.15),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Column(
                                children: [

                                  Icon(
                                    Icons.verified_rounded,
                                    color: Colors.white,
                                  ),

                                  SizedBox(height: 8),

                                  Text(
                                    "Secure Panel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .92,
                  children: [

                    StatCard(
                      title: "Books",
                      value: books.toString(),
                      icon: Icons.menu_book,
                    ),

                    StatCard(
                      title: "Users",
                      value: users.toString(),
                      icon: Icons.people,
                    ),

                    StatCard(
                      title: "Wishlist",
                      value: wishlist.toString(),
                      icon: Icons.favorite,
                    ),

                    StatCard(
                      title: "Library",
                      value: library.toString(),
                      icon: Icons.library_books,
                    ),
                  ],
                ),


                const SizedBox(height: 30),

                const Text(
                  "Recent Books",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                StreamBuilder(
                  stream: AdminBookService.recentBooks(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      children: snapshot.data!.docs.map<Widget>((doc) {
                        final data = doc.data() as Map<String, dynamic>;

                        return RecentBookTile(
                          title: data["title"] ?? "",
                          author: data["author"] ?? "",
                        );
                      }).toList(),
                    );
                  },
                ),
                const Text(
                  "Management",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: .90,
                  children: [

                    DashboardCard(
                      title: "Upload Book",
                      icon: Icons.upload_file,
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const AdminUploadBookScreen(),
                          ),
                        );
                      },
                    ),

                    DashboardCard(
                      title: "Manage Books",
                      icon: Icons.edit_note,
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ManageBooksScreen(),
                          ),
                        );
                      },
                    ),

                    DashboardCard(
                      title: "Manage Users",
                      icon: Icons.people_alt,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ManageUsersScreen(),
                          ),
                        );
                      },
                    ),

                    DashboardCard(
                      title: "Categories",
                      icon: Icons.category,
                      color: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const CategoriesScreen(),
                          ),
                        );
                      },
                    ),

                    DashboardCard(
                      title: "Analytics",
                      icon: Icons.bar_chart,
                      color: Colors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const AnalyticsScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardCard(
                      title: "Settings",
                      icon: Icons.settings,
                      color: const Color(0xFFA61E4D),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),

                  ],
                ),


                const SizedBox(height: 30),

                const Text(
                  "Recent Users",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                StreamBuilder(
                  stream: AdminBookService.recentUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      children: snapshot.data!.docs.map<Widget>((doc) {
                        final data = doc.data() as Map<String, dynamic>;

                        return RecentUserTile(
                          name: data["name"] ?? "Unknown User",
                          role: data["role"] ?? "User",
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 28),

                const Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                FutureBuilder(
                  future: ActivityService.recentActivities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "No recent activity",
                          ),
                        ),
                      );
                    }

                    final activities = snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount: activities.length,
                        separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return ActivityTile(
                            activity: activities[index],
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),


              ],
            ),
          );
        },
      ),
    );
  }
}