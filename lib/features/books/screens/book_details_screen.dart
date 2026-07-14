import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../wishlist/services/wishlist_service.dart';
import '../models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });


  Future<void> addToLibrary() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('library')
        .doc(book.id)
        .set({
      'bookId': book.id,
      'addedAt': Timestamp.now(),
      'status': 'unread',
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            SizedBox(
              width: double.infinity,
              height: 350,

              child: Image.network(
                book.coverImage,
                fit: BoxFit.cover,
              ),
            ),


            Padding(
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


                  const SizedBox(height:10),


                  Text(
                    "by ${book.author}",

                    style: const TextStyle(
                      fontSize:18,
                      color:Colors.grey,
                    ),
                  ),


                  const SizedBox(height:20),


                  Row(
                    children:[

                      const Icon(
                        Icons.star,
                        color:Colors.amber,
                      ),

                      const SizedBox(width:5),

                      Text(book.rating.toString()),


                      const Spacer(),


                      Text(
                        "₹${book.price}",

                        style: const TextStyle(
                          fontSize:24,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height:25),


                  Chip(
                    label:Text(book.category),
                  ),


                  const SizedBox(height:20),


                  Row(
                    children:[

                      const Icon(Icons.menu_book),

                      const SizedBox(width:8),

                      Text("${book.pages} Pages"),

                    ],
                  ),


                  const SizedBox(height:30),


                  const Text(
                    "Description",

                    style:TextStyle(
                      fontSize:22,
                      fontWeight:FontWeight.bold,
                    ),
                  ),


                  const SizedBox(height:10),


                  Text(
                    book.description,

                    style:const TextStyle(
                      fontSize:16,
                      height:1.6,
                    ),
                  ),


                  const SizedBox(height:40),


                  // Wishlist Button

                  StreamBuilder<bool>(
                    stream: WishlistService.isWishlisted(book.id),

                    builder:(context,snapshot){

                      final isWishlisted =
                          snapshot.data ?? false;


                      return SizedBox(

                        width:double.infinity,


                        child:FilledButton.icon(

                          icon:Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),


                          label:Text(
                            isWishlisted
                                ? "Remove from Wishlist"
                                : "Add to Wishlist",
                          ),


                          onPressed:() async {

                            if(isWishlisted){

                              await WishlistService
                                  .removeFromWishlist(
                                book.id,
                              );

                            }else{

                              await WishlistService
                                  .addToWishlist(
                                book.id,
                              );

                            }

                          },
                        ),
                      );
                    },
                  ),



                  const SizedBox(height:15),



                  // Add To Library Button

                  SizedBox(

                    width:double.infinity,


                    child:OutlinedButton.icon(

                      onPressed:() async {

                        await addToLibrary();


                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          const SnackBar(

                            content:Text(
                              "Book added to library 📚",
                            ),

                          ),

                        );

                      },


                      icon:const Icon(
                        Icons.library_add,
                      ),


                      label:const Text(
                        "Add to Library",
                      ),

                    ),
                  ),



                  const SizedBox(height:25),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}