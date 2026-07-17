import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bookverse/features/books/models/book_model.dart';
import 'package:bookverse/features/books/screens/book_details_screen.dart';
import 'package:bookverse/features/books/widgets/book_card.dart';
import 'package:bookverse/providers/book_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "BookVerse",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: books.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, _) => Center(
          child: Text(error.toString()),
        ),

        data: (bookList) {
          if (bookList.isEmpty) {
            return const Center(
              child: Text("No books available."),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(booksProvider);
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "All Books",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .62,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    BookModel book = bookList[index];

                    return BookCard(
                      book: book,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookDetailsScreen(book: book),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}