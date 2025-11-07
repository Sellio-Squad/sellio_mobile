import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

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
                color: context.theme.colors.body ?? Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  size: 48,
                  color: context.theme.colors.body,
                ),
                const SizedBox(height: 8),
                Text(
                  'Upload',
                  style: context.theme.typography.textTheme.labelMedium.copyWith(
                    color: context.theme.colors.body,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
