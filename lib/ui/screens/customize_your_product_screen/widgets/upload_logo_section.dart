import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class UploadLogoSection extends StatefulWidget {
  const UploadLogoSection({super.key});

  @override
  State<UploadLogoSection> createState() => _UploadLogoSectionState();
}

class _UploadLogoSectionState extends State<UploadLogoSection> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            height: 280,
            decoration: BoxDecoration(
              color: context.theme.colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.theme.colors.disabled ?? Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_selectedImage != null)
                  Positioned(
                    top: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.upload,
                        width: 48,
                        height: 78,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
