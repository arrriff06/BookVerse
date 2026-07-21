import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../request_book/models/request_book_model.dart';
import '../services/admin_request_service.dart';
import '../widgets/request_card.dart';

class BookRequestsScreen extends ConsumerStatefulWidget {
  const BookRequestsScreen({super.key});

  @override
  ConsumerState<BookRequestsScreen> createState() =>
      _BookRequestsScreenState();
}

class _BookRequestsScreenState
    extends ConsumerState<BookRequestsScreen> {
  String filter = "all";
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Requests"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<RequestBookModel>>(
        stream: AdminRequestService.getRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<RequestBookModel> requests =
          snapshot.data!;

          //----------------------------------------
          // Search
          //----------------------------------------

          if (search.isNotEmpty) {
            requests = requests.where((e) {
              return e.bookName
                  .toLowerCase()
                  .contains(
                search.toLowerCase(),
              ) ||
                  e.author
                      .toLowerCase()
                      .contains(
                    search.toLowerCase(),
                  ) ||
                  e.userName
                      .toLowerCase()
                      .contains(
                    search.toLowerCase(),
                  );
            }).toList();
          }

          //----------------------------------------
          // Filter
          //----------------------------------------

          if (filter != "all") {
            requests = requests
                .where(
                  (e) =>
              e.status == filter,
            )
                .toList();
          }

          return Column(
            children: [

              //----------------------------------
              // Search
              //----------------------------------

              Padding(
                padding:
                const EdgeInsets.all(16),
                child: TextField(
                  decoration:
                  const InputDecoration(
                    hintText:
                    "Search requests...",
                    prefixIcon:
                    Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                ),
              ),

              //----------------------------------
              // Filters
              //----------------------------------

              SingleChildScrollView(
                scrollDirection:
                Axis.horizontal,
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Row(
                  children: [

                    _chip("all", "All"),

                    _chip(
                        "pending",
                        "Pending"),

                    _chip(
                        "uploading",
                        "Uploading"),

                    _chip(
                        "uploaded",
                        "Uploaded"),

                    _chip(
                        "rejected",
                        "Rejected"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              //----------------------------------
              // Requests
              //----------------------------------

              Expanded(
                child: ListView.builder(
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
                        // next
                      },

                      onUpload: () async {
                        await AdminRequestService
                            .setUploading(
                          request.id,
                        );
                      },

                      onReject: () async {
                        await AdminRequestService
                            .rejectRequest(
                          request.id,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _chip(
      String value,
      String text,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: filter == value,
        label: Text(text),
        onSelected: (_) {
          setState(() {
            filter = value;
          });
        },
      ),
    );
  }
}