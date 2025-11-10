import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class UploadLogoSection extends StatefulWidget {
  final Function(File?) onImageSelected;
  final File? selectedImage;

  const UploadLogoSection({
    super.key,
    required this.onImageSelected,
    this.selectedImage,
  });

  @override
  State<UploadLogoSection> createState() => _UploadLogoSectionState();
}

class _UploadLogoSectionState extends State<UploadLogoSection> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedImage = widget.selectedImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload logo or image',
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: context.theme.colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.theme.colors.disabled ?? Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: selectedImage == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.upload,
                  width: 48,
                  height: 78,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap to upload',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                selectedImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
