import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_book_tile.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Books"),
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SearchBarWidget(),

            const SizedBox(height: 20),

            Expanded(
              child: books.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),

                error: (e, _) => Center(
                  child: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),

                data: (bookList) {
                  if (bookList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.search_off,
                            size: 90,
                            color: Colors.grey.shade400,
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "No books found",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Try another keyword.",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: bookList.length,
                    itemBuilder: (context, index) {
                      return SearchBookTile(
                        book: bookList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}