import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../books/models/book_model.dart';
import '../books/screens/book_details_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Please login to view your library."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Library"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('library')
            .orderBy('addedAt', descending: true)
            .snapshots(),
        builder: (context, librarySnapshot) {
          if (librarySnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!librarySnapshot.hasData ||
              librarySnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No books in your library 📚",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final docs = librarySnapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final bookId =
              docs[index]['bookId'] as String;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('books')
                    .doc(bookId)
                    .get(),
                builder: (context, bookSnapshot) {
                  if (!bookSnapshot.hasData) {
                    return const SizedBox();
                  }

                  if (!bookSnapshot.data!.exists) {
                    return const SizedBox();
                  }

                  final book =
                  BookModel.fromFirestore(bookSnapshot.data!);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookDetailsScreen(book: book),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(10),
                              child: Image.network(
                                book.coverImage,
                                width: 90,
                                height: 130,
                                fit: BoxFit.cover,
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
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    book.author,
                                    style:
                                    const TextStyle(
                                      color: Colors.grey,
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
                                      const SizedBox(width: 4),
                                      Text(
                                        book.rating
                                            .toString(),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  FilledButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              BookDetailsScreen(
                                                  book: book),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.menu_book),
                                    label:
                                    const Text("Read"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}