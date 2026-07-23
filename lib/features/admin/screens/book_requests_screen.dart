import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../request_book/models/request_book_model.dart';
import '../services/admin_request_service.dart';
import '../widgets/request_card.dart';
import '../widgets/request_filter_chip.dart';
import '../widgets/request_status_dialog.dart';
import '../widgets/upload_book_dialog.dart';

class BookRequestsScreen extends StatefulWidget {
  const BookRequestsScreen({super.key});

  @override
  State<BookRequestsScreen> createState() =>
      _BookRequestsScreenState();
}

class _BookRequestsScreenState
    extends State<BookRequestsScreen> {
  String selectedFilter = "All";

  final TextEditingController searchController =
  TextEditingController();

  final List<String> filters = [
    "All",
    "Pending",
    "Uploaded",
    "Rejected",
  ];

  Stream<QuerySnapshot> getRequests() {
    return FirebaseFirestore.instance
        .collection("request_books")
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Requests"),
      ),
      body: Column(
        children: [
          //------------------------------------
          // Search
          //------------------------------------

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search book or author",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),

          //------------------------------------
          // Filters
          //------------------------------------

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: filters.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                  const EdgeInsets.only(
                    right: 10,
                  ),
                  child: RequestFilterChip(
                    title: filters[index],
                    selected:
                    filters[index] ==
                        selectedFilter,
                    onTap: () {
                      setState(() {
                        selectedFilter =
                        filters[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          //------------------------------------
          // Requests
          //------------------------------------

          Expanded(
            child:
            StreamBuilder<QuerySnapshot>(
              stream: getRequests(),
              builder:
                  (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child:
                    Text("No Requests"),
                  );
                }

                List<RequestBookModel> requests =
                snapshot.data!.docs
                    .map(
                      (e) =>
                      RequestBookModel
                          .fromFirestore(
                          e),
                )
                    .toList();

                //--------------------------------
                // Status Filter
                //--------------------------------

                if (selectedFilter != "All") {
                  requests = requests
                      .where(
                        (request) =>
                    request.status
                        .toLowerCase() ==
                        selectedFilter
                            .toLowerCase(),
                  )
                      .toList();
                }

                //--------------------------------
                // Search Filter
                //--------------------------------

                final keyword =
                searchController.text
                    .trim()
                    .toLowerCase();

                if (keyword.isNotEmpty) {
                  requests = requests
                      .where(
                        (request) =>
                    request.bookName
                        .toLowerCase()
                        .contains(
                        keyword) ||
                        request.author
                            .toLowerCase()
                            .contains(
                            keyword),
                  )
                      .toList();
                }

                if (requests.isEmpty) {
                  return const Center(
                    child: Text(
                      "No matching requests.",
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                  const EdgeInsets.all(
                      16),
                  itemCount:
                  requests.length,
                  itemBuilder:
                      (context, index) {
                    final request =
                    requests[index];

                    return RequestCard(
                      request: request,

                      onView: () {
                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              request.notes
                                  .isEmpty
                                  ? "No notes added."
                                  : request.notes,
                            ),
                          ),
                        );
                      },

                      onUpload: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              UploadBookDialog(
                                request: request,
                              ),
                        );
                      },

                      onReject: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              RequestStatusDialog(
                                currentStatus:
                                request.status,
                                onSave:
                                    (status) async {
                                  switch (
                                  status) {
                                    case "uploading":
                                      await AdminRequestService
                                          .setUploading(
                                        requestId:
                                        request.id,
                                        uid: request
                                            .uid,
                                        bookName:
                                        request
                                            .bookName,
                                      );
                                      break;

                                    case "uploaded":
                                      break;

                                    case "rejected":
                                      await AdminRequestService
                                          .rejectRequest(
                                        requestId:
                                        request.id,
                                        uid: request
                                            .uid,
                                        reason:
                                        "Rejected by Admin",
                                        bookName:
                                        request
                                            .bookName,
                                      );
                                      break;
                                  }
                                },
                              ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}