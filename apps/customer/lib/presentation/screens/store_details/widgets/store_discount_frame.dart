import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              left: 6,
              right: 6,
              bottom: 2,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.upTo,
                    width: 24,
                    height: 12,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$discount%',
                    style:
                        context.theme.typography.textTheme.labelSmall.copyWith(
                      color: context.theme.colors.secondary,
                    ),
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