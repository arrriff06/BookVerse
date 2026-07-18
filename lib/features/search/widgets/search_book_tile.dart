import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/screens/book_details_screen.dart';

class SearchBookTile extends StatelessWidget {
  final BookModel book;

  const SearchBookTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookDetailsScreen(
                book: book,
              ),
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
                    width: 75,
                    height: 110,
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

              const SizedBox(width: 15),

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
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [

                        Chip(
                          label: Text(
                            book.category,
                          ),
                        ),

                        Chip(
                          avatar: const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          label: Text(
                            book.rating
                                .toStringAsFixed(1),
                          ),
                        ),

                        Chip(
                          label: Text(
                            "${book.pages} Pages",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}