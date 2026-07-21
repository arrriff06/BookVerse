import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../search/screens/search_screen.dart';
import '../../../providers/book_provider.dart';

import '../widgets/home_header.dart';
import '../widgets/home_shimmer.dart';
import '../widgets/premium_banner.dart';
import '../widgets/section_title.dart';
import '../widgets/horizontal_book_list.dart';
import '../widgets/continue_reading_card.dart';
import '../widgets/daily_pick_card.dart';
import '../widgets/recommendation_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      body: SafeArea(
        child: books.when(
          loading: () => const HomeShimmer(),

          error: (error, _) => Center(
            child: Text(error.toString()),
          ),

          data: (bookList) {
            if (bookList.isEmpty) {
              return const Center(
                child: Text("No books available"),
              );
            }

            final recommended = bookList;

            final trending = [...bookList.reversed];

            final topRated = [...bookList]
              ..sort(
                    (a, b) =>
                    b.rating.compareTo(a.rating),
              );

            final recent = [...bookList.reversed];

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(booksProvider);
              },

              child: ListView(
                physics:
                const BouncingScrollPhysics(),
                children: [

                  //--------------------------------------------------
                  // HEADER
                  //--------------------------------------------------

                  HomeHeader(
                    userName: "Arif",
                    onSearch: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SearchScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  //--------------------------------------------------
                  // PREMIUM
                  //--------------------------------------------------

                  const PremiumBanner(),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // RECOMMENDED
                  //--------------------------------------------------

                  SectionTitle(
                    title: "✨ Recommended For You",
                    subtitle:
                    "Books you'll love",
                    onSeeAll: () {},
                  ),

                  const SizedBox(height: 18),

                  HorizontalBookList(
                    books: recommended,
                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // TRENDING
                  //--------------------------------------------------

                  SectionTitle(
                    title: "🔥 Trending This Week",
                    subtitle:
                    "Popular among readers",
                    onSeeAll: () {},
                  ),

                  const SizedBox(height: 18),

                  HorizontalBookList(
                    books: trending,
                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // CONTINUE READING
                  //--------------------------------------------------

                  const Padding(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "📚 Continue Reading",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  ContinueReadingCard(
                    book: bookList.first,
                    progress: .68,
                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // DAILY PICK
                  //--------------------------------------------------

                  const DailyPickCard(),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // BECAUSE YOU LIKED
                  //--------------------------------------------------

                  RecommendationBanner(
                    bookTitle:
                    bookList.first.title,
                  ),

                  const SizedBox(height: 25),

                  SectionTitle(
                    title:
                    "❤️ Because You Liked",
                    subtitle:
                    bookList.first.title,
                  ),

                  const SizedBox(height: 18),

                  HorizontalBookList(
                    books: recommended,
                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // TOP RATED
                  //--------------------------------------------------

                  SectionTitle(
                    title: "⭐ Top Rated",
                    subtitle:
                    "Highest rated books",
                    onSeeAll: () {},
                  ),

                  const SizedBox(height: 18),

                  HorizontalBookList(
                    books: topRated,
                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // RECENT
                  //--------------------------------------------------

                  SectionTitle(
                    title:
                    "Recently Added",
                    subtitle:
                    "Fresh arrivals",
                    onSeeAll: () {},
                  ),

                  const SizedBox(height: 18),

                  HorizontalBookList(
                    books: recent,
                  ),

                  const SizedBox(height: 45),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}