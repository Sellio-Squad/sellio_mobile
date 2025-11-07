import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../core/design_system/constants/assets.dart';

class UploadLogoSection extends StatelessWidget {
  const UploadLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload logo or image',
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            // TODO: handle image upload
          },
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: context.theme.colors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.theme.colors.disabled ?? Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                 SvgPicture.asset(
                  Assets.upload,
                   width: 48,
                  height: 78,
                  fit: BoxFit.scaleDown,
                ),
                ],
            ),
          ),
        ),
      ],
    );
  }
}
