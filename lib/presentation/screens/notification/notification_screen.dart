import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

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
          title: "Notifications",
          showBackButton: true,
        ),
        body: buildNotificationSections(context),
      ),
    );
  }
}