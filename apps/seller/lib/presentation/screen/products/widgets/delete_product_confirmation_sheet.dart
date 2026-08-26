import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';

class DeleteProductConfirmationSheet extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteProductConfirmationSheet({
    super.key,
    required this.onDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDelete,
  }) {
    return SellioBottomSheet.show(
      context: context,
      child: DeleteProductConfirmationSheet(onDelete: onDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(colors),
          const Gap(24),
          Text(
            context.local.delete_product,
            style: textTheme.titleSmall.copyWith(
              color: colors.title,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            context.local.delete_confirmation,
            style: textTheme.bodySmall.copyWith(
              color: colors.body,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          Row(
            children: [
              Expanded(
                child: SellioButton(
                  text: context.local.cancel,
                  textColor: colors.primary,
                  backgroundColor: colors.surfaceLow,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const Gap(12),
              Expanded(
                child: SellioButton(
                  text: context.local.delete,
                  backgroundColor: colors.red,
                  onTap: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _buildIcon(SellioColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: colors.errorVariant,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        AppImages.delete,
        colorFilter: ColorFilter.mode(
          colors.red,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
