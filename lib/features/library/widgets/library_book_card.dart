import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/screens/book_details_screen.dart';
import '../services/library_service.dart';

class LibraryBookCard extends StatelessWidget {
  final BookModel book;

  const LibraryBookCard({
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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
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
                    width: 85,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const Center(
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

                    const SizedBox(height: 12),

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

                    const SizedBox(height: 16),

                    const LinearProgressIndicator(
                      value: 0,
                      minHeight: 6,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Not Started",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [

                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookDetailsScreen(
                                        book: book,
                                      ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.menu_book,
                            ),
                            label: const Text(
                              "Read",
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        IconButton(
                          onPressed: () async {
                            await LibraryService
                                .removeFromLibrary(
                              book.id,
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
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