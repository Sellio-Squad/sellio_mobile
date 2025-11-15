import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: context.theme.colors.body.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: context.theme.typography.textTheme.titleMedium.copyWith(
              color: context.theme.colors.body,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When you have notifications, they will appear here',
            textAlign: TextAlign.center,
            style: context.theme.typography.textTheme.bodyMedium.copyWith(
              color: context.theme.colors.body.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}