import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import 'builders/notification_sections_builder.dart';
import 'notification_bloc_providers.dart';
import 'notification_listeners.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotificationBlocProviders(
      child: _NotificationScreenContent(),
    );
  }
}

class _NotificationScreenContent extends StatelessWidget {
  const _NotificationScreenContent();

  @override
  Widget build(BuildContext context) {
    return NotificationListeners(
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.notifications,
          showBackButton: true,
        ),
        body: buildNotificationSections(context),
      ),
    );
  }
}
