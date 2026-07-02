import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class OrdersErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const OrdersErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: context.theme.colors.red.withOpacity(0.8),
            ),
            const SizedBox(height: 16),
            Text(
              context.local.something_went_wrong,
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                color: context.theme.colors.title,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: context.theme.typography.textTheme.bodyMedium.copyWith(
                color: context.theme.colors.body,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SellioButton(
              text: context.local.retry,
              fullWidth: false,
              horizontalPadding: 24,
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
