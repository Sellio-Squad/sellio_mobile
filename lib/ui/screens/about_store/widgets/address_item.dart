import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../core/design_system/constants/app_icons.dart';

class AddressItem extends StatelessWidget {
  final String address;

  const AddressItem({super.key,required this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.theme.colors.primaryVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              width: 40,
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.pinLocation,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address,
                style: context.theme.typography.textTheme.labelMedium.copyWith(
                  color: context.theme.colors.body,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
