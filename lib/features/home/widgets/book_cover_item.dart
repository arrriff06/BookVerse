import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/screens/book_details_screen.dart';

class BookCoverItem extends StatelessWidget {
  final BookModel book;

  const BookCoverItem({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailsScreen(book: book),
          ),
        );
      },
      child: SizedBox(
        width: 145,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //-----------------------------------
            // BOOK COVER
            //-----------------------------------

            Hero(
              tag: book.id,
              child: Container(
                height: 205,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .12),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: .72,
                  child: Image.network(
                    book.coverImage,
                    fit: BoxFit.cover,

                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.menu_book,
                          size: 60,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            //-----------------------------------
            // TITLE
            //-----------------------------------

            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 4),

            //-----------------------------------
            // AUTHOR
            //-----------------------------------

            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 8),

            //-----------------------------------
            // RATING + PAGES
            //-----------------------------------

            Row(
              children: [

                const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 16,
                ),

                const SizedBox(width: 3),

                Text(
                  book.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),

                const Spacer(),

                Text(
                  "${book.pages} p",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}