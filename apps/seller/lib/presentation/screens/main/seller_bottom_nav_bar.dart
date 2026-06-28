import 'package:design_system/constants/app_images.dart';
import 'package:design_system/widgets/sellio_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/l10n/localization_service.dart';

class SellerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCenterButtonTap;

  const SellerBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SellioBottomNavBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        SellioBottomNavItem(
          iconPath: AppImages.home,
          selectedIconPath: AppImages.homeSelected,
          label: context.local.dashboard,
          index: 0,
        ),
        SellioBottomNavItem(
          iconPath: AppImages.orderIcon,
          label: context.local.orders,
          index: 1,
        ),
        SellioBottomNavItem(
          iconPath: AppImages.product,
          label: context.local.products,
          index: 3,
        ),
        SellioBottomNavItem(
          iconPath: AppImages.account,
          selectedIconPath: AppImages.accountSelected,
          label: context.local.account,
          index: 4,
        ),
      ],
      centerButton: SellioBottomNavCenterButton(
        index: 2,
        iconPath: AppImages.add,
        onTap: onCenterButtonTap,
      ),
    );
  }
}
