import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class NotificationLoadingState extends StatelessWidget {
  const NotificationLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.theme.colors.primary,
      ),
    );
  }
}
