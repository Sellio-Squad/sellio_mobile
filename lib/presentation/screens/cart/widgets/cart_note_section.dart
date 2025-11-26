import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/sellio_text_field.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../constants/cart_constants.dart';

class CartNoteSection extends StatelessWidget {
  final TextEditingController controller;

  const CartNoteSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.note_about_order,
          style: textTheme.titleMedium.copyWith(color: colors.title),
        ),
        const Gap(8),
        SellioTextField(
          controller: controller,
          isParagraph: true,
          hintText: context.local.write_here,
          maxLine: CartConstants.maxNoteLines,
        ),
      ],
    );
  }
}