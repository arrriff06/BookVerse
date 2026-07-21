import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import 'book_cover_item.dart';

class HorizontalBookList extends StatelessWidget {
  final List<BookModel> books;

  const HorizontalBookList({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 315,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 18),
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            child: BookCoverItem(
              book: books[index],
            ),
          );
        },
      ),
    );
  }
}