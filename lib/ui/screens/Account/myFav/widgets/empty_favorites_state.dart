import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF5F9),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: SvgPicture.asset(
                Assets.heartRemove,
                width: 64,
                height: 64,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'No favourite items!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.5,
              color: Color(0xE01F1F1F),
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle text
          const Text(
            'Start exploring and saving your favorite items here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.57, // 22px line height
              color: Color(0xA61F1F1F), // 66% opacity
            ),
          ),
          const SizedBox(height: 12),

          // Start Exploring Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF520826),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              fixedSize: const Size(151, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
              elevation: 4,
            ),
            onPressed: () {
              // TODO: Navigate to Explore/Home section
            },
            child: const Text(
              'Start Exploring',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.57,
                color: Color(0xDEFFFFFF), // 87% opacity white
              ),
            ),
          ),
        ],
      ),
    );
  }
}
