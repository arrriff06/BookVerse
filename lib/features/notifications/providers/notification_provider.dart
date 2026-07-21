import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/notification_model.dart';
import '../services/notification_service.dart';

final notificationProvider =
StreamProvider<List<NotificationModel>>(
        (ref) {
      return NotificationService
          .getNotifications();
    });