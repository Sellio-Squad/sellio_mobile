import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';

class StoreDiscountTag extends StatelessWidget {
  final String discount;

  const StoreDiscountTag({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AppImages.storeDiscountFrame, fit: BoxFit.fill),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              left: 12,
              right: 12,
              bottom: 2,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppImages.discountIcon,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$discount%',
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
