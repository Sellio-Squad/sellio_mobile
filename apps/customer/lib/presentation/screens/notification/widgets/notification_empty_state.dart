import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

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
            context.local.no_notifications_yet,
            style: context.theme.typography.textTheme.titleMedium.copyWith(
              color: context.theme.colors.body,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.local.notifications_will_appear_here,
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
