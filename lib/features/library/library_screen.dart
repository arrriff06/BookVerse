import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../books/models/book_model.dart';
import '../books/widgets/book_card.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Library"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('library')
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
                "Your library is empty 📚",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final ids =
          librarySnapshot.data!.docs.map((e) => e.id).toList();

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('books')
                .where(FieldPath.documentId, whereIn: ids)
                .get(),
            builder: (context, booksSnapshot) {
              if (booksSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!booksSnapshot.hasData ||
                  booksSnapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No books found"),
                );
              }

              final books = booksSnapshot.data!.docs
                  .map((doc) => BookModel.fromFirestore(doc))
                  .toList();

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: books.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.50,
                ),
                itemBuilder: (context, index) {
                  return BookCard(
                    book: books[index],
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