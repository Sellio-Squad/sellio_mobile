import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../core/design_system/constants/assets.dart';

class DiscountTag extends StatelessWidget {
  final String discountText;

  const DiscountTag({super.key, required this.discountText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          Assets.discountFrame,
          fit: BoxFit.fill,
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12 ,bottom: 2),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.discountIcon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                     context.theme.colors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    discountText,
                    style: context.theme.typography.textTheme.labelSmall
                    .copyWith(color: context.theme.colors.secondary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}