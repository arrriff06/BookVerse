import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/screens/book_details_screen.dart';
import '../../../core/theme/app_colors.dart';

class ContinueReadingCard extends StatelessWidget {
  final BookModel book;
  final double progress;

  const ContinueReadingCard({
    super.key,
    required this.book,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookDetailsScreen(book: book),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [

                //------------------------------------
                // BOOK COVER
                //------------------------------------

                Hero(
                  tag: "continue_${book.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      book.coverImage,
                      width: 90,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          width: 90,
                          height: 130,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.menu_book,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 18),

                //------------------------------------
                // DETAILS
                //------------------------------------

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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        book.author,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [

                          Text(
                            "$percent%",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            "${book.pages} pages",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor:
                          Colors.grey.shade200,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 18),

                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                          AppColors.primary,
                          foregroundColor:
                          Colors.white,
                          minimumSize:
                          const Size.fromHeight(46),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
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
                          Icons.auto_stories_rounded,
                        ),
                        label: const Text(
                          "Continue Reading",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}