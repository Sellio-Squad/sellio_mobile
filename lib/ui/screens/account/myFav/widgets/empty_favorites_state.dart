import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../../../core/design_system/constants/app_images.dart';
import '../../../../../core/design_system/themes/sellio_colors.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 140),
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: SellioColors.light.primaryVariant,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.heartRemove,
                width: 64,
                height: 64,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.local.no_favourite_items,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xE01F1F1F),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 320,
                  child: Text(
                    context.local.start_exploring_and_saving_your_favorite_items_here,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.57,
                      color: Color.fromARGB(255, 117, 117, 117),
                    ),
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SellioColors.light.primary,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              fixedSize: const Size(180, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
              elevation: 4,
            ),
            onPressed: () {
            },
            child: Text(
              context.local.start_exploring,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.57,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}