import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../reader/screens/pdf_reader_screen.dart';
import '../../reader/services/download_service.dart';
import '../models/book_model.dart';
import 'package:bookverse/features/library/services/library_service.dart';
class BookDetailsScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  Widget infoTile(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,

            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: book.id,
                child: CachedNetworkImage(
                  imageUrl: book.coverImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) =>
                  const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "by ${book.author}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [

                      Chip(label: Text(book.category)),

                      Chip(label: Text("${book.pages} Pages")),

                      Chip(label: Text("⭐ ${book.rating}")),

                      Chip(
                        backgroundColor: Colors.green.shade100,
                        label: const Text(
                          "FREE",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [

                          infoTile(
                            Icons.menu_book,
                            "Pages",
                            "${book.pages}",
                          ),

                          infoTile(
                            Icons.language,
                            "Language",
                            book.language,
                          ),

                          infoTile(
                            Icons.business,
                            "Publisher",
                            book.publisher,
                          ),

                          infoTile(
                            Icons.calendar_today,
                            "Published",
                            book.publishedDate,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    book.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PdfReaderScreen(
                                pdfUrl: book.pdfUrl,
                                title: book.title,
                              ),
                            ),
                          );
                        },
                      icon: const Icon(Icons.menu_book),
                      label: const Text("Read Now"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await DownloadService.downloadPdf(
                          url: book.pdfUrl,
                          fileName: book.title,
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Download PDF"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        debugPrint("Save button clicked");

                        try {
                          await LibraryService.addToLibrary(book);

                          debugPrint("Book saved successfully");

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Book added to Library"),
                              ),
                            );
                          }
                        } catch (e) {
                          debugPrint("ERROR: $e");

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.library_add),
                      label: const Text("Save to Library"),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "About Author",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${book.author} is a renowned author. Author biography will be loaded from Firestore in a future update.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Similar Books",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const SizedBox(
                    height: 170,
                    child: Center(
                      child: Text(
                        "Coming Soon",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}