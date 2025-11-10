import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioBottomSheet extends StatelessWidget {
  final Widget child;
  final VoidCallback? onDismiss;

  const SellioBottomSheet({
    super.key,
    required this.child,
    this.onDismiss,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    VoidCallback? onDismiss,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: SellioBottomSheet(
              onDismiss: onDismiss,
              child: child,
            ),
          ),
    ).then((value) {
      onDismiss?.call();
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        top: false,
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CustomDragHandle(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            color: context.theme.colors.stroke,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
