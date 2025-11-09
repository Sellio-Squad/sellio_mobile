import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';

PreferredSizeWidget buildHomeAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(68.0),
    child: HomeAppBar(
      onNotificationTap: () {
        // TODO: Navigate to notifications
      },
    ),
  );
}