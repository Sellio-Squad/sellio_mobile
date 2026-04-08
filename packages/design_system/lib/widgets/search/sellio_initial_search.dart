import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class SellioInitialSearch extends StatelessWidget {
  final String title;
  final String? iconAsset;
  final double heightRatio;

  const SellioInitialSearch({
    super.key,
    required this.title,
    this.iconAsset,
    this.heightRatio = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightRatio,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconAsset ?? AppImages.searchIcon),
          const Gap(12),
          Text(
            title,
            style: context.theme.typography.textTheme.titleSmall.copyWith(
              color: context.theme.colors.title,
            ),
          ),
        ],
      ),
    );
  }
}
