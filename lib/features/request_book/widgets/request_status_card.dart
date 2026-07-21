import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../models/request_book_model.dart';
import 'status_chip.dart';

class RequestStatusCard extends StatelessWidget {
  final RequestBookModel request;

  final VoidCallback? onRead;

  final VoidCallback? onFeedback;

  const RequestStatusCard({
    super.key,
    required this.request,
    this.onRead,
    this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat(
      "dd MMM yyyy",
    ).format(
      request.createdAt.toDate(),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 2,
      shadowColor: AppColors.primary.withValues(
        alpha: .08,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            //----------------------------------
            // TOP
            //----------------------------------

            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    size: 42,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        request.bookName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        request.author,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      StatusChip(
                        status: request.status,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Requested on $date",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //----------------------------------

            const SizedBox(height: 18),

            Divider(
              color: Colors.grey.shade300,
            ),

            const SizedBox(height: 12),

            if (request.status == "pending")
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "We're reviewing your request. You'll receive a notification once the book becomes available.",
                      style: TextStyle(
                        color:
                        Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),

            if (request.status == "uploading")
              Row(
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Good news! Your requested book is currently being uploaded.",
                      style: TextStyle(
                        color:
                        Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),

            if (request.status == "uploaded")
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "🎉 Your requested book is now available!",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [

                      Expanded(
                        child: FilledButton.icon(
                          onPressed: onRead,
                          icon: const Icon(
                            Icons.auto_stories,
                          ),
                          label: const Text(
                            "Read Now",
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      OutlinedButton.icon(
                        onPressed: onFeedback,
                        icon: const Icon(
                          Icons.rate_review,
                        ),
                        label: const Text(
                          "Feedback",
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            if (request.status == "rejected")
              Row(
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Sorry! We couldn't upload this book due to availability or copyright restrictions.",
                      style: TextStyle(
                        color:
                        Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}