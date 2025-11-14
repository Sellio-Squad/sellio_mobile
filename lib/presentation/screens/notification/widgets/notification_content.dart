import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import 'notification_date_header.dart';
import 'notification_item.dart';

class NotificationContent extends StatelessWidget {
  final Map<String, List<NotificationModel>> groupedNotifications;
  final Future<void> Function() onRefresh;

  const NotificationContent({
    super.key,
    required this.groupedNotifications,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: groupedNotifications.entries.map((entry) {
          final date = entry.key;
          final notifications = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationDateHeader(date: date),
              ...notifications.map((notification) =>
                  NotificationItem(
                    notification: notification,
                  )),
            ],
          );
        }).toList(),
      ),
    );
  }
}