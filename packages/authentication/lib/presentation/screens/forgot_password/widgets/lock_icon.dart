import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';

class LockIcon extends StatelessWidget {
  const LockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: colors.primaryVariant,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppImages.lock,
          width: 48,
          height: 48,
        ),
      ),
    );
  }
}
