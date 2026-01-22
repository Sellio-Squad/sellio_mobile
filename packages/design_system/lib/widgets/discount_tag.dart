import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_images.dart';
import '../themes/sellio_theme_provider.dart';

class DiscountTag extends StatelessWidget {
  final String discountText;

  const DiscountTag({super.key, required this.discountText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppImages.discountFrame,
          fit: BoxFit.fill,
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12 ,bottom: 6),
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