import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class FeaturedToggleSection extends StatelessWidget {
  const FeaturedToggleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        return Column(
          children: [
            // Product Visibility Toggle
            _ToggleCard(
              icon: AppImages.openEye,
              title: 'Product Visibility',
              value: state.isAvailable,
              onChanged: (value) =>
                  context.read<CreateProductCubit>().toggleAvailable(value),
            ),
            const Gap(12),
            // Is Featured Toggle
            _ToggleCard(
              icon: AppImages.magicStick,
              title: 'Featured Product',
              value: state.isFeatured,
              onChanged: (value) =>
                  context.read<CreateProductCubit>().toggleFeatured(value),
            ),
          ],
        );
      },
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              context.theme.colors.body,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: context.theme.typography.textTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colors.title,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: context.theme.colors.onPrimary,
              activeTrackColor: context.theme.colors.primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: context.theme.colors.stroke,
            ),
          ),
        ],
      ),
    );
  }
}
