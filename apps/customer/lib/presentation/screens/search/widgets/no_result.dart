import 'package:design_system/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/category_section.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySection(),
        const Gap(24),
        Image.asset(AppImages.noResultSearchIcon),
        Text(context.local.no_results_found),
        Text(
          context.local.please_check_your_spelling_or_try_a_different_search,
        ),
      ],
    );  }
}
