import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SpecialOfferCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String discount;
  final VoidCallback? onTap;

  const SpecialOfferCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.discount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF2C0113),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [

              // Top-left blur
              Positioned(
                top: -24,
                left: -24,
                child: Container(
                  width: 234,
                  height: 86,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colors.onPrimary.withOpacity(0.12),
                        blurRadius: 100,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom-right blur
              Positioned(
                bottom: -24,
                right: -24,
                child: Container(
                  width: 234,
                  height: 86,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colors.onPrimary.withOpacity(0.12),
                        blurRadius: 100,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),

              // Product Image (Right Side)
              Positioned(
                right: 16,
                top: 20,
                bottom: 25,
                child: Container(
                  width: 125,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Product Image
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/special_offer_1.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content (Left Side)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                right: 140,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      Expanded(
                        child: Text(
                          title,
                          style: textTheme.titleMedium.copyWith(
                            color: context.theme.colors.onPrimary,
                          ),
                          maxLines: 3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Button with Blur Effect
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.onPrimary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // Handle button press
                                },
                                borderRadius: BorderRadius.circular(100),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    "BROWSE IT NOW!",
                                    style: textTheme.labelSmall.copyWith(
                                      color: colors.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}