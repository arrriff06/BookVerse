import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../books/models/book_model.dart';
import '../books/widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        title: const Text(
          "BookVerse",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('books')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error:\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          // No Books
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Books Available",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tap the + button to upload your first book.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          for (final doc in snapshot.data!.docs) {
            debugPrint(doc.data().toString());
          }

          debugPrint("Documents: ${snapshot.data!.docs.length}");

          for (final doc in snapshot.data!.docs) {
            debugPrint(doc.id);
          }

          final books = snapshot.data!.docs
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
              childAspectRatio: .50,
            ),

            itemBuilder: (context, index) {
              return BookCard(
                book: books[index],
              );
            },
          );
        },
      ),
    );
  }
}