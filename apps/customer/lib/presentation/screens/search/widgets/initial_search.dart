import 'package:design_system/constants/app_images.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class InitialSearch extends StatelessWidget {
  const InitialSearch(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.searchIcon),
          Text(context.local.start_exploring_your_favorite_items),
        ],
      ),
    );
  }
}
