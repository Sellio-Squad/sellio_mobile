import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> notifications = [
    // today
    NotificationModel(
      state: 0,
      orderId: "1x23456",
      storeName: "Sweet Lovers - Pasteleria",
      time: "11:12 PM",
      date: "2025-11-03",
    ),
    NotificationModel(
      state: 1,
      orderId: "1x23456",
      storeName: "Sweet Lovers - Pasteleria",
      time: "11:13 PM",
      date: "2025-11-03",
    ),
    NotificationModel(
      state: 2,
      orderId: "1x23456",
      storeName: "Sweet Lovers - Pasteleria",
      time: "11:15 PM",
      date: "2025-11-03",
    ),
    NotificationModel(
      state: 1,
      orderId: "2x78901",
      storeName: "Burger Zone",
      time: "10:12 PM",
      date: "2025-11-03",
    ),

    // yesterday
    NotificationModel(
      state: 2,
      orderId: "3x11111",
      storeName: "Pizza Lovers",
      time: "08:15 PM",
      date: "2025-11-02",
    ),
    NotificationModel(
      state: 2,
      orderId: "3x11111",
      storeName: "Pizza Lovers",
      time: "08:20 PM",
      date: "2025-11-02",
    ),
    NotificationModel(
      state: 2,
      orderId: "3x11111",
      storeName: "Pizza Lovers",
      time: "08:25 PM",
      date: "2025-11-02",
    ),
    // older
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:00 PM",
      date: "2025-11-01",
    ),
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:10 PM",
      date: "2025-11-01",
    ),
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:20 PM",
      date: "2025-11-01",
    ),
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:30 PM",
      date: "2025-11-01",
    ),
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:40 PM",
      date: "2025-11-01",
    ),
    NotificationModel(
      state: 0,
      orderId: "4x22222",
      storeName: "Coffee Dreams",
      time: "09:50 PM",
      date: "2025-11-01",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    notifications.sort(
      (a, b) => b.date.compareTo(a.date),
    );
    final grouped = <String, List<NotificationModel>>{};
    for (final n in notifications) {
      grouped.putIfAbsent(n.date, () => []).add(n);
    }

    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        title: "Notifications",
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: grouped.entries.map((entry) {
          final date = entry.key;
          final items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateHeader(date: date),
              ...items.map((n) => NotificationItem(
                    state: n.state,
                    orderId: n.orderId,
                    storeName: n.storeName,
                    time: n.time,
                  )),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final int state;
  final String orderId;
  final String storeName;
  final String time;

  const NotificationItem({
    super.key,
    required this.state,
    required this.orderId,
    required this.storeName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, orderState) = switch (state) {
      0 => (Assets.packageDelivered, "has been placed successfully"),
      1 => (Assets.packageDelivery, "has been delivered successfully"),
      2 => (Assets.packageRemove, "has been cancelled"),
      _ => (Assets.packageRemove, "has been cancelled"),
    };

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.theme.colors.surface,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.title,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 16, bottom: 2),
                    child: Text.rich(
                      TextSpan(
                        text: "Your order #$orderId from ",
                        style: context.theme.typography.textTheme.bodySmall
                            .copyWith(
                          color: context.theme.colors.body,
                        ),
                        children: [
                          TextSpan(
                            text: storeName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Rubik',
                            ),
                          ),
                          TextSpan(
                            text: " $orderState.",
                            style: context.theme.typography.textTheme.bodySmall
                                .copyWith(
                              color: context.theme.colors.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      time,
                      style: context.theme.typography.textTheme.labelSmall
                          .copyWith(
                        color: context.theme.colors.body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Divider(
            color: context.theme.colors.stroke,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.tryParse(date);
    String displayText = date;

    if (parsedDate != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final dateOnly =
          DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

      if (dateOnly == today) {
        displayText = "Today";
      } else if (dateOnly == yesterday) {
        displayText = "Yesterday";
      } else {
        displayText = DateFormat('MMM dd, yyyy').format(parsedDate);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
      child: Row(
        children: [
          Text(
            displayText,
            style: context.theme.typography.textTheme.labelSmall.copyWith(
              color: context.theme.colors.body,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: context.theme.colors.stroke,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationModel {
  final int state;
  final String orderId;
  final String storeName;
  final String time;
  final String date;

  NotificationModel({
    required this.state,
    required this.orderId,
    required this.storeName,
    required this.time,
    required this.date,
  });
}
