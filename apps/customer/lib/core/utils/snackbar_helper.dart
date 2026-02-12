import 'dart:async';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

abstract class SnackBarHelper {
  static const Duration _errorDuration = Duration(seconds: 4);
  static const Duration _successDuration = Duration(seconds: 3);

  static void showError(BuildContext context, String message) {
    _showOverlaySnackBar(
      context,
      _SnackBarConfig(
        message: message,
        isError: true,
        duration: _errorDuration,
        title: context.local.error,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showOverlaySnackBar(
      context,
      _SnackBarConfig(
        message: message,
        isError: false,
        duration: _successDuration,
        title: context.local.success,
      ),
    );
  }

  static void _showOverlaySnackBar(
    BuildContext context,
    _SnackBarConfig config,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 26,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SellioSnackBar(
              isError: config.isError,
              message: config.message,
              onCancelTap: () => overlayEntry.remove(),
              title: config.title,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(config.duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

class _SnackBarConfig {
  final String message;
  final bool isError;
  final Duration duration;
  final String title;

  const _SnackBarConfig({
    required this.message,
    required this.isError,
    required this.duration,
    required this.title,
  });
}
