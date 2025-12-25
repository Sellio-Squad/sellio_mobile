import 'package:design_system/constants/app_images.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class InitialSearch extends StatelessWidget {
  const InitialSearch(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.searchIcon),
          const Gap(12),
          Text(
              context.local.start_exploring_your_favorite_items,
              style: context.theme.typography.textTheme.titleSmall.copyWith(
                color: context.theme.colors.title,
              )
          ),
        ],
      ),
    );
  }
}
