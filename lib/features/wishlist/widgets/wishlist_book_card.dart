import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/screens/book_details_screen.dart';
import '../services/wishlist_service.dart';

class WishlistBookCard extends StatelessWidget {
  final BookModel book;

  const WishlistBookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookDetailsScreen(book: book),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [

              Hero(
                tag: book.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: book.coverImage,
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                    const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (_, __, ___) =>
                    const Icon(Icons.book),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      book.author,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [

                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          book.rating.toStringAsFixed(1),
                        ),

                        const Spacer(),

                        Text(
                          "${book.pages} Pages",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await WishlistService.removeFromWishlist(
                    book.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}