import 'package:design_system/constants/app_images.dart';
import 'package:design_system/widgets/sellio_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/l10n/localization_service.dart';

class CustomerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCenterButtonTap;

  const CustomerBottomNavBar({
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
          label: context.local.home,
          index: 0,
        ),
        SellioBottomNavItem(
          iconPath: AppImages.cart,
          selectedIconPath: AppImages.cartSelected,
          label: context.local.cart,
          index: 1,
        ),
        SellioBottomNavItem(
          iconPath: AppImages.thrift,
          selectedIconPath: AppImages.thriftSelected,
          label: context.local.thrift,
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
        iconPath: AppImages.magicStick,
        onTap: onCenterButtonTap,
      ),
    );
  }
}
