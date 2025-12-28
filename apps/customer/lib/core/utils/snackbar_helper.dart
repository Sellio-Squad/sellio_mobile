import 'dart:async';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

abstract class SnackBarHelper {
  static const Duration _errorDuration = Duration(seconds: 4);
  static const Duration _successDuration = Duration(seconds: 3);

  static void showError(BuildContext context, String message) {
    _showOverlaySnackBar(
      context: context,
      message: message,
      isError: true,
      duration: _errorDuration,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showOverlaySnackBar(
      context: context,
      message: message,
      isError: false,
      duration: _successDuration,
    );
  }

  static void _showOverlaySnackBar({
    required BuildContext context,
    required String message,
    required bool isError,
    required Duration duration,
  }) {
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
              isError: isError,
              message: message,
              onCancelTap: () => overlayEntry.remove(),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}