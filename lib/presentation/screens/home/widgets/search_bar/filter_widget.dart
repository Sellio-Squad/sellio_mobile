import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../../core/design_system/constants/app_images.dart';

class FilterWidget extends StatelessWidget {
  final Function() onFilterIconClicked;

  const FilterWidget({super.key, required this.onFilterIconClicked});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colors.primaryVariant,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      child: InkWell(
        onTap: onFilterIconClicked,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: SizedBox(
          height: 48,
          width: 48,
          child: Center(
            child: SvgPicture.asset(
              AppImages.filter,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
