import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../../core/design_system/constants/app_images.dart';
import '../../../../../core/design_system/themes/sellio_theme_provider.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 140),
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: context.theme.colors.primaryVariant,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.heartRemove,
                width: 64,
                height: 64,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.local.no_favourite_items,
                  textAlign: TextAlign.center,
                  style: context.theme.typography.textTheme.titleSmall.copyWith(
                    color: context.theme.colors.title,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.local
                      .start_exploring_and_saving_your_favorite_items_here,
                  textAlign: TextAlign.center,
                  style: context.theme.typography.textTheme.bodyMedium.copyWith(
                    color: context.theme.colors.body,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.theme.colors.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 32,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              context.go('/home');
            },
            child: Text(
              context.local.start_exploring,
              style: context.theme.typography.textTheme.labelMedium.copyWith(
                color: context.theme.colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
