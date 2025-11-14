import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../utils/notification_utils.dart';

class NotificationDateHeader extends StatelessWidget {
  final String date;

  const NotificationDateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final displayText = NotificationUtils.formatDateHeader(date);

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