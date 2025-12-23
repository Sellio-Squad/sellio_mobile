import 'package:design_system/constants/app_images.dart';
import 'package:design_system/themes/sellio_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/category_section.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          const CategorySection(),

          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.noResultSearchIcon),
                  const Gap(16),

                  Text(
                    context.local.no_results_found,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.titleSmall.copyWith(
                      color: context.theme.colors.title,
                    ),
                  ),

                  const Gap(8),

                  Text(
                    context.local
                        .please_check_your_spelling_or_try_a_different_search,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.bodySmall.copyWith(
                      color: context.theme.colors.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
