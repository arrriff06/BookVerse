import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  Widget box({
    double width = double.infinity,
    double height = 20,
    double radius = 12,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            /// Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      box(width: 140, height: 24),
                      const SizedBox(height: 10),
                      box(width: 220),
                    ],
                  ),
                ),
                box(width: 48, height: 48, radius: 24),
              ],
            ),

            const SizedBox(height: 25),

            /// Premium Banner
            box(height: 170, radius: 24),

            const SizedBox(height: 28),

            /// Categories
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) =>
                    box(width: 100, height: 42, radius: 25),
                separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
                itemCount: 5,
              ),
            ),

            const SizedBox(height: 30),

            box(width: 170, height: 26),

            const SizedBox(height: 20),

            SizedBox(
              height: 285,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) =>
                    box(width: 150, height: 280, radius: 20),
                separatorBuilder: (_, __) =>
                const SizedBox(width: 16),
                itemCount: 5,
              ),
            ),

            const SizedBox(height: 30),

            box(height: 170, radius: 24),

            const SizedBox(height: 30),

            box(height: 170, radius: 24),

            const SizedBox(height: 30),

            box(width: 170, height: 26),

            const SizedBox(height: 20),

            SizedBox(
              height: 285,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) =>
                    box(width: 150, height: 280, radius: 20),
                separatorBuilder: (_, __) =>
                const SizedBox(width: 16),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}