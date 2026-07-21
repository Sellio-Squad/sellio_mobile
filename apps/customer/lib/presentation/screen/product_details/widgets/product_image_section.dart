import 'dart:math';

import 'package:design_system/widgets/sellio_remote_image.dart';
import 'package:flutter/material.dart';

Widget productImagesSection(List<String> images) {
  final paddedImages = [
    ...images,
    ...List.filled(max(0, 3 - images.length), ''),
  ];

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SellioRemoteImage(
              imageUrl: paddedImages[0],
              width: 110,
              height: 110,
            ),
            const SizedBox(height: 4),
            SellioRemoteImage(
              imageUrl: paddedImages[1],
              width: 110,
              height: 110,
            ),
          ],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: SellioRemoteImage(
            imageUrl: paddedImages[2],
            height: 224,
          ),
        ),
      ],
    ),
  );
}
