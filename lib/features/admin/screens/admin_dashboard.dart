import 'package:flutter/material.dart';

import '../services/admin_book_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/stat_card.dart';

import 'admin_upload_book_screen.dart';
import 'analytics_screen.dart';
import 'categories_screen.dart';
import 'manage_books_screen.dart';
import 'manage_users_screen.dart';


class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookVerse Admin"),
        centerTitle: true,
      ),
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

                const Text(
                  "👋 Welcome Admin",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Manage your BookVerse application",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.15,
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
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
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

                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}