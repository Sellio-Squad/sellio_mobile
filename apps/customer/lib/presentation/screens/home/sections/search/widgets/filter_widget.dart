import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterWidget extends StatelessWidget {
  final Function() onFilterIconClicked;

  const FilterWidget({super.key, required this.onFilterIconClicked});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colors.primaryVariant,
      borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(12),
        bottomEnd: Radius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onFilterIconClicked,
        child: SizedBox(
          height: 48,
          width: 48,
          child: Center(
            child: SvgPicture.asset(
              AppImages.filter,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
