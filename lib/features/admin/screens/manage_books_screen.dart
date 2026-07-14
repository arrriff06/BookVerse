import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../books/models/book_model.dart';
import '../../books/services/book_service.dart';

import '../widgets/admin_book_card.dart';
import '../widgets/admin_search_bar.dart';
import '../widgets/delete_book_dialog.dart';

import 'edit_book_screen.dart';

class ManageBooksScreen extends StatefulWidget {
  const ManageBooksScreen({super.key});

  @override
  State<ManageBooksScreen> createState() => _ManageBooksScreenState();
}

class _ManageBooksScreenState extends State<ManageBooksScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  String search = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BookModel> filterBooks(List<BookModel> books) {
    if (search.isEmpty) return books;

    return books.where((book) {
      return book.title
          .toLowerCase()
          .contains(search.toLowerCase()) ||
          book.author
              .toLowerCase()
              .contains(search.toLowerCase());
    }).toList();
  }

  Future<void> deleteBook(BookModel book) async {
    final confirm =
    await showDeleteBookDialog(context);

    if (confirm != true) return;

    await BookService.deleteBook(book.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${book.title} deleted successfully",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Books"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            AdminSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: BookService.getBooks(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Books Found",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final books = snapshot.data!.docs
                      .map(
                        (doc) =>
                        BookModel.fromFirestore(doc),
                  )
                      .toList();

                  final filteredBooks =
                  filterBooks(books);

                  return Column(
                    children: [

                      Align(
                        alignment:
                        Alignment.centerLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.only(
                              bottom: 12),
                          child: Text(
                            "Total Books : ${filteredBooks.length}",
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {},
                          child: ListView.builder(
                            itemCount:
                            filteredBooks.length,
                            itemBuilder:
                                (context, index) {
                              final book =
                              filteredBooks[index];

                              return AdminBookCard(
                                book: book,

                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditBookScreen(
                                            book: book,
                                          ),
                                    ),
                                  );
                                },

                                onDelete: () {
                                  deleteBook(book);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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