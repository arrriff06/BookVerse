import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../request_book/models/request_book_model.dart';

class RequestCard extends StatelessWidget {
  final RequestBookModel request;

  final VoidCallback onView;
  final VoidCallback onUpload;
  final VoidCallback onReject;

  const RequestCard({
    super.key,
    required this.request,
    required this.onView,
    required this.onUpload,
    required this.onReject,
  });

  Color _statusColor() {
    switch (request.status) {
      case "uploaded":
        return Colors.green;

      case "uploading":
        return Colors.blue;

      case "rejected":
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date =
    DateFormat("dd MMM yyyy").format(
      request.createdAt.toDate(),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 3,
      shadowColor:
      AppColors.primary.withValues(alpha: .08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            //----------------------------------
            // Top
            //----------------------------------

            Row(
              children: [

                Container(
                  width: 65,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primary
                        .withValues(alpha: .08),
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    size: 40,
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
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        request.author,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [

                          Icon(
                            Icons.person,
                            size: 18,
                            color:
                            Colors.grey.shade600,
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              request.userName,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [

                          Icon(
                            Icons.email_outlined,
                            size: 18,
                            color:
                            Colors.grey.shade600,
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              request.email,
                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        date,
                        style: TextStyle(
                          color:
                          Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            //----------------------------------

            Row(
              children: [

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                    _statusColor().withValues(
                      alpha: .12,
                    ),
                    borderRadius:
                    BorderRadius.circular(30),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                IconButton(
                  tooltip: "View",
                  onPressed: onView,
                  icon: const Icon(
                    Icons.visibility,
                  ),
                ),

                IconButton(
                  tooltip: "Upload",
                  color: Colors.green,
                  onPressed: onUpload,
                  icon: const Icon(
                    Icons.upload_file,
                  ),
                ),

                IconButton(
                  tooltip: "Reject",
                  color: Colors.red,
                  onPressed: onReject,
                  icon: const Icon(
                    Icons.close,
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