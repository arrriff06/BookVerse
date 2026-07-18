import 'package:flutter/material.dart';

import '../services/admin_analytics_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int books = 0;
  int users = 0;
  int featured = 0;
  int trending = 0;
  int downloads = 0;
  int readers = 0;
  int categories = 0;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    try {
      books = await AdminAnalyticsService.totalBooks();
      users = await AdminAnalyticsService.totalUsers();
      featured = await AdminAnalyticsService.featuredBooks();
      trending = await AdminAnalyticsService.trendingBooks();
      downloads = await AdminAnalyticsService.totalDownloads();
      readers = await AdminAnalyticsService.totalReaders();
      categories = await AdminAnalyticsService.totalCategories();
    } catch (e) {
      debugPrint("Analytics Error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),
      body: RefreshIndicator(
        onRefresh: loadAnalytics,
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [

            _card(
              Icons.menu_book,
              "Books",
              books.toString(),
              Colors.blue,
            ),

            _card(
              Icons.people,
              "Users",
              users.toString(),
              Colors.green,
            ),

            _card(
              Icons.star,
              "Featured",
              featured.toString(),
              Colors.orange,
            ),

            _card(
              Icons.local_fire_department,
              "Trending",
              trending.toString(),
              Colors.red,
            ),

            _card(
              Icons.download,
              "Downloads",
              downloads.toString(),
              Colors.purple,
            ),

            _card(
              Icons.chrome_reader_mode,
              "Readers",
              readers.toString(),
              Colors.teal,
            ),

            _card(
              Icons.category,
              "Categories",
              categories.toString(),
              Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}