import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/request_book_provider.dart';
import '../services/request_book_service.dart';
import '../widgets/request_form.dart';
import '../widgets/request_status_card.dart';

class RequestBookScreen extends ConsumerStatefulWidget {
  const RequestBookScreen({super.key});

  @override
  ConsumerState<RequestBookScreen> createState() =>
      _RequestBookScreenState();
}

class _RequestBookScreenState
    extends ConsumerState<RequestBookScreen> {
  final _bookController = TextEditingController();
  final _authorController = TextEditingController();
  final _notesController = TextEditingController();

  String _language = "English";
  String _category = "Self Help";

  @override
  void dispose() {
    _bookController.dispose();
    _authorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (_bookController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter book name and author.",
          ),
        ),
      );
      return;
    }

    ref.read(requestLoadingProvider.notifier).state = true;

    try {
      await RequestBookService.submitRequest(
        bookName: _bookController.text.trim(),
        author: _authorController.text.trim(),
        language: _language,
        category: _category,
        notes: _notesController.text.trim(),
      );

      _bookController.clear();
      _authorController.clear();
      _notesController.clear();

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),
          title: const Text(
            "Request Submitted 🎉",
          ),
          content: const Text(
            "Thank you for your request.\n\n"
                "We'll review it and, if it can be legally provided, "
                "it's usually uploaded within 24 hours.\n\n"
                "You'll receive a notification once it's available.",
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    ref.read(requestLoadingProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final requests =
    ref.watch(myRequestsProvider);

    final loading =
    ref.watch(requestLoadingProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          "Request a Book",
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              // Notification screen later
            },
            icon: const Icon(
              Icons.notifications_rounded,
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myRequestsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    "Can't find your favorite book?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Submit a request and we'll review it.\n\n"
                        "If the book can be legally provided, "
                        "it's usually uploaded within 24 hours.",
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            RequestForm(
              bookController: _bookController,
              authorController:
              _authorController,
              notesController:
              _notesController,
              language: _language,
              category: _category,
              isLoading: loading,
              onLanguageChanged: (v) {
                setState(() {
                  _language = v!;
                });
              },
              onCategoryChanged: (v) {
                setState(() {
                  _category = v!;
                });
              },
              onSubmit: _submitRequest,
            ),

            const SizedBox(height: 35),

            const Text(
              "My Requests",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            requests.when(
              loading: () =>
              const Center(
                child:
                CircularProgressIndicator(),
              ),

              error: (e, _) =>
                  Center(
                    child: Text(
                      e.toString(),
                    ),
                  ),

              data: (list) {
                if (list.isEmpty) {
                  return Container(
                    padding:
                    const EdgeInsets.all(
                      40,
                    ),
                    child: Column(
                      children: const [

                        Icon(
                          Icons.menu_book,
                          size: 70,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 20),

                        Text(
                          "No requests yet",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Request a book and it will appear here.",
                          textAlign:
                          TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: list
                      .map(
                        (request) =>
                        RequestStatusCard(
                          request: request,

                          onRead: () {
                            // Open uploaded book later
                          },

                          onFeedback: () {
                            // Feedback dialog later
                          },
                        ),
                  )
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}