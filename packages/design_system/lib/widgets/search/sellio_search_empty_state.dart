import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class SellioSearchEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget topWidget;
  final String? iconAsset;
  final double heightRatio;

  const SellioSearchEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.topWidget = const SizedBox.shrink(),
    this.iconAsset,
    this.heightRatio = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightRatio,
      child: Column(
        children: [
          topWidget,
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(iconAsset ?? AppImages.noResultSearchIcon),
                  const Gap(16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.titleSmall
                        .copyWith(color: context.theme.colors.title),
                  ),
                  const Gap(8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.bodySmall
                        .copyWith(color: context.theme.colors.body),
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
