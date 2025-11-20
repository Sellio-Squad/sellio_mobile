import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/design_system/constants/app_images.dart';


Widget buildLockIcon(dynamic colors) {
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