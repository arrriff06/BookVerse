import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen
    extends ConsumerWidget {
  const NotificationScreen(
      {super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref) {
    final notifications =
    ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor:
      const Color(0xffF8F8F8),

      appBar: AppBar(
        backgroundColor:
        AppColors.primary,
        foregroundColor:
        Colors.white,
        title: const Text(
            "Notifications"),
      ),

      body: notifications.when(
        loading: () =>
        const Center(
            child:
            CircularProgressIndicator()),

        error: (e, _) =>
            Center(
                child:
                Text(e.toString())),

        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Icon(
                    Icons
                        .notifications_none_rounded,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No notifications yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder:
                (_, index) =>
                NotificationTile(
                  notification:
                  list[index],
                ),
          );
        },
      ),
    );
  }
}