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
    DateFormat("dd MMM yyyy").format(request.createdAt.toDate());

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //------------------------------------------
            // Top
            //------------------------------------------

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: 70,
                  height: 95,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.primary,
                    size: 42,
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
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
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

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [

                          Chip(
                            label: Text(request.language),
                          ),

                          Chip(
                            label: Text(request.category),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [

                          Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.grey.shade600,
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              request.userName,
                              overflow:
                              TextOverflow.ellipsis,
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
                            color: Colors.grey.shade600,
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              request.email,
                              overflow:
                              TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Request ID : ${request.id.substring(0, 8)}",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            //------------------------------------------
            // Status
            //------------------------------------------

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor()
                        .withValues(alpha: .12),
                    borderRadius:
                    BorderRadius.circular(30),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                IconButton(
                  tooltip: "View",
                  onPressed: onView,
                  icon: const Icon(Icons.visibility),
                ),

                if (request.status == "pending") ...[

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
              ],
            ),

            //------------------------------------------
            // Uploaded Banner
            //------------------------------------------

            if (request.status == "uploaded") ...[

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: .08),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [

                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "This requested book has been uploaded successfully.",
                      ),
                    ),
                  ],
                ),
              ),
            ],

            //------------------------------------------
            // Rejected Banner
            //------------------------------------------

            if (request.status == "rejected") ...[

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: .08),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [

                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "This request has been rejected.",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}